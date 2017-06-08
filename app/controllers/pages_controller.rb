class PagesController < ApplicationController
  before_action :authenticate_user!
  
  def about_us
  end
end
