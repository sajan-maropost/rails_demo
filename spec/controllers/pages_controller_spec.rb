require 'rails_helper'

describe PagesController do 
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "GET about_us" do

    it "Should render about_us page" do
      get :about_us
      expect(response).to render_template :about_us
    end

  end
end