class ContactFormsController < ApplicationController
  before_action :authenticate_user!
  
  def new
  	@query = UserQuery.new
  end

  def create
  	@query = UserQuery.new(user_query_params)
    if @query.save
      flash[:notice] = "Message sent successfully"
      ContactMailer.acknowledge_mail(user_query_params[:email]).deliver_now
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  private
    def user_query_params
      params.require(:user_query).permit(:name, :email, :mobile, :description)
    end
end
