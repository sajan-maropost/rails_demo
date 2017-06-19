class RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    @auto_password = User.generate_password

    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      WelcomeMailer.welcome_email(resource.name, resource.email, @auto_password).deliver_later
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_to do |format|
          format.html { respond_with resource, location: after_sign_up_path_for(resource) }
          format.json { render json: { status: "Success", message: "Successful", code: 200 } }
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_to do |format|
          format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
          format.json { render json: { status: "Success", message: "Successful, please activate account", code: 200 } }
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
          format.html { respond_with resource }
          format.json { render json: { status: "Failure", message: resource.errors.full_messages, code: 500 } }
        end
    end
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
