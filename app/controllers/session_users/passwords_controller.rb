# -*- encoding : utf-8 -*-
class SessionUsers::PasswordsController < Devise::PasswordsController
  before_action :configure_params, only: [:permit_reset_password,:create]

  def new
    super
  end

  def permit_reset_password

    self.resource = resource_class.new
    @email = params[:session_user][:email]

    if @email.blank?
      resource.errors[:base] << 'Correo no puede estar en blanco'
      render 'new'
      return
    end

    @session_user_db  = SessionUser.find_by(email: @email)

    if @session_user_db.nil?
      resource.errors[:base] << 'Correo no registrado'
      render 'new'
      return
    end

    @pregunta = @session_user_db.usuario_sput.pregunta_secreta
  end

  def create
    self.resource = resource_class.new
    @email = params[:session_user][:email]
    @respuesta =espacios_blancos_l_r(params[:session_user][:respuesta])

    if @email.blank? or @respuesta.blank?
      resource.errors[:base] << 'Respuesta no puede estar en blanco'
      render 'new'
      return
    end

    @session_user_db  = SessionUser.find_by(email: @email)

    if @session_user_db.nil?
      resource.errors[:base] << 'Correo no registrado'
      render 'new'
      return
    end

    @respuesta_bd = espacios_blancos_l_r(@session_user_db.usuario_sput.respuesta)

    unless @respuesta_bd.casecmp(@respuesta) == 0
      @pregunta = @session_user_db.usuario_sput.pregunta_secreta
      resource.errors[:base] << 'Respuesta incorrecta intente de nuevo'
      render 'permit_reset_password'
      return
    end
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    super
  end

  private
  def configure_params
    params.require(:session_user).permit(:email, :respuesta)
  end

end
