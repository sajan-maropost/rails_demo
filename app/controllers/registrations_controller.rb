class RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @auto_password = User.generate_password
    super
    WelcomeMailer.welcome_email(resource.name, resource.email, @auto_password).deliver_now
  end

  protected 

  def build_resource(hash=nil)
    hash = hash.merge({ password: @auto_password, password_confirmation: @auto_password })
    super(hash)
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

end
