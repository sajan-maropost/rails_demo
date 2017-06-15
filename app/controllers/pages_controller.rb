class PagesController < ApplicationController
  before_action :authenticate_user!
  acts_as_token_authentication_handler_for User
  skip_before_action :authenticate_user_from_token
  def about_us
  end
end
