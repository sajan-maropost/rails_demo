class SessionsController < Devise::SessionsController

  skip_before_action :authenticate_user_from_token

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    set_flash_message!(:notice, :signed_in)
    yield resource if block_given?
    respond_to do |format|
      format.html do 
        respond_with resource, location: after_sign_in_path_for(resource)
      end

      format.json do
        respond_with_authentication_token(resource)
      end
    end
  end

  protected

  def respond_with_authentication_token(resource)
    render json: {
      success: true,
      auth_token: resource.authentication_token,
      email: resource.email
    }
  end

end