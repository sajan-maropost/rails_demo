class ContactFormsController < ApplicationController
  before_action :authenticate_user!
  
  def new
  	@query = UserQuery.new
  end

  def create
  	@query = UserQuery.new(user_query_params)

    respond_to do |format|
      if @query.save
        ContactMailer.acknowledge_mail(user_query_params[:email]).deliver_later
        format.html { redirect_back fallback_location: create_contact_query_url, notice: "Message sent successfully" }
        format.json { render json: { status: "Success", message: "Successful", code: 200 } }
        format.js
    	else
        format.html { render 'new' }
        format.json { render json: { status: "Failure", message: @query.errors.full_messages, code: 500 } }
        format.js
    	end
    end

  end

  private
    def user_query_params
      params.require(:user_query).permit(:name, :email, :mobile, :description)
    end
end
