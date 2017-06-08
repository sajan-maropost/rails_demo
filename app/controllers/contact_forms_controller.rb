class ContactFormsController < ApplicationController
  before_action :authenticate_user!
  
  def new
  	@query = UserQuery.new
  end

  def create
  	@query = UserQuery.new(user_query_params)

    respond_to do |format|
      if @query.save
        ContactMailer.acknowledge_mail(user_query_params[:email]).deliver_now
        format.html { redirect_to :back, notice: "Message sent successfully" }
        format.js
    	else
        format.html { render 'new' }
        format.js
    	end
    end

  end

  private
    def user_query_params
      params.require(:user_query).permit(:name, :email, :mobile, :description)
    end
end
