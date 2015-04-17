class SessionUsers::SessionsController < Devise::SessionsController
  before_filter :autenticar_session_user!, only: [:edit_password,
                                                    :update_password]
  # before_action :configure_sign_in_params

# GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    # super
    self.resource = warden.authenticate!(auth_options)

    sign_in(resource_name, resource)
    yield resource if block_given?
    after_sign_in_path_modified(resource)
    # fin super

    if resource.representante_legal.temporal?
      flash[:warning]= 'Debes cambiar tu clave para activar tu cuenta'
      redirect_to cambio_contrasena_session_user_path
      return
    else
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      redirect_to root_path
      return
    end

  end

  # DELETE /resource/sign_out
  def destroy
    super
  end


  #metodos para modificar password si representante legal esta en estado temporal
  def edit_password
    @session_user = current_session_user
  end

  def update_password
    @session_user = SessionUser.find(current_session_user.id)
    if @session_user.update(configure_sign_in_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @session_user, :bypass => true
      @session_user.representante_legal.autorizado!
      redirect_back_or root_path
    else
      render 'session_users/sessions/edit_password'
    end
  end

  private

  def after_sign_in_path_modified(resource_or_scope)
    stored_location_for(resource_or_scope)
  end

  # You can put the params you want to permit in the empty array.
  def configure_sign_in_params
    params.require(:session_user).permit(:email, :password,
                                         :password_confirmation,:remember_me)
  end
end
