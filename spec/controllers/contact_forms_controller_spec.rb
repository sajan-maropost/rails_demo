require 'rails_helper'

describe ContactFormsController do 
  let(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  describe "POST create" do

    it "creates a new message if params are valid" do
      post :create, params: {user_query: {name: "test", email: "test@mailinator.com", description: "test desc"}}
      expect(flash[:notice]).to match(/^Message sent successfully/)
    end

    it "fails to create without name attribute" do
      post :create, params: {user_query: {mobile: "1234567890", 
        email: "test@mailinator.com", description: "test desc"}, :format => :json}
      body = JSON.parse(response.body)
      expect(body['message']).to include("Name can't be blank")
    end

    it "fails to create without Email field" do
      post :create, params: {user_query: {mobile: "1234567890", 
        name: "test", description: "test desc"}, :format => :json}
      body = JSON.parse(response.body)
      expect(body['message']).to include("Email can't be blank")
    end

    it "fails to create without description(message) field" do
      post :create, params: {user_query: {mobile: "1234567890", 
        email: "test@mailinator.com"}, :format => :json}
      body = JSON.parse(response.body)
      expect(body['message']).to include("Description can't be blank")
    end

    it "fails to create if name is invalid" do
      # name contains number in below spec
      post :create, params: {user_query: {name: "test1", 
        email: "test@mailinator.com", description: "test desc"}, :format => :json}
      body = JSON.parse(response.body)
      expect(body['message']).to include("Name :Only letters allowed.")
    end

    it "fails to create if email is invalid" do
      # name contains number in below spec
      post :create, params: {user_query: {name: "test", 
        email: "test@mailinator.", description: "test desc"}, :format => :json}
      body = JSON.parse(response.body)
      expect(body['message']).to include("Email Enter a valid email")
    end

    context "if mobile is invalid" do
      it "fails to create if mobile contains nonnumeric character" do
        # name contains number in below spec
        post :create, params: {user_query: {name: "test", 
          email: "test@mailinator.com", description: "test desc", mobile: "123456test"}, :format => :json}
        body = JSON.parse(response.body)
        expect(body['message']).to include("Mobile is not a number")
      end

      it "fails to create if mobile contains less than 10 digit" do
        # name contains number in below spec
        post :create, params: {user_query: {name: "test", 
          email: "test@mailinator.com", description: "test desc", mobile: "123456789"}, :format => :json}
        body = JSON.parse(response.body)
        expect(body['message']).to include("Mobile is too short (minimum is 10 characters)")
      end
    end
  end
end