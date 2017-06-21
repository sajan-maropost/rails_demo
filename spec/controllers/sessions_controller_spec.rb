require 'rails_helper'

describe SessionsController do 

  describe "POST create" do

    context 'when password is invalid' do
      it 'renders the page with error' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = create(:user)
        post :create, session: { email: user.email, password: 'invalid' }

        expect(response).to render_template(:new)
        expect(flash[:alert]).to match(/^Invalid Email or password./)
      end
    end

    context 'when password is valid' do
      it 'sets the user in the session and redirects them to root page' do
        @request.env["devise.mapping"] = Devise.mappings[:user]

        user = create(:user)
        post :create, params: { user: { email: user.email, password: user.password } }

        expect(controller.current_user).to eq user
      end
    end

    context 'request format is JSON' do
      it 'returns auth_token' do
        @request.env["devise.mapping"] = Devise.mappings[:user]

        user = create(:user)
        post :create, params: { user: { email: user.email, password: user.password } , :format => :json}

        body = JSON.parse(response.body)
        expect(body['auth_token']).not_to be(nil)
      end
    end
  end
end