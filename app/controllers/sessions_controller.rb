class SessionsController < Devise::SessionsController

  before_action :authenticate_user!, only: [:destroy]
  def new
    #Save the previous page
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # create a new user session
  # This method is using builtin methods provided by
  # has_secure_password
  # in User model
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # Destroy session
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  private

  # It creates session and redirect
  def create_session_using(authorized_user)
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to session.delete(:return_to)
    else
      flash[:notice] = "Incorrect email or password"
      render 'new'
    end
  end

end
