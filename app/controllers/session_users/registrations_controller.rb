# -*- encoding : utf-8 -*-
class SessionUsers::RegistrationsController < Devise::RegistrationsController
  include SessionUsersHelper
  include ApplicationHelper
  before_filter :configure_sign_up_params, only: [:create]
  before_action :generar_lista, only:[:nuevo_registro]
  before_action :generar_lista_operadoras_movil, only: [:create,:new]

  def new
    @usuario_sput_guardado = UsuarioSput.find_by(numero_doc: params[:tciudadano][:documento])

    #Condicion para usuario ya registrado en nuevo sistema SIGETT
    unless @usuario_sput_guardado.nil?
      unless @usuario_sput_guardado.representante_legal.nil?
        flash[:danger]=
            'RepresentanteLegal registrado, intente recuperar contraseña si la ha olvidado'
        redirect_to action: 'nuevo_registro'
        return
      end
    end

    #buscamos en saime si este ciudadano existe
    @ciudadano = Tciudadano.find_cedula(params[:tciudadano][:documento])

    if @ciudadano.nil?
      flash[:danger]=
          'Combinación de cedula y fecha de nacimiento no encontrada'
      redirect_to action: 'nuevo_registro'
      return
    else
      @nacionalidad = params[:tciudadano][:nacionalidad]

      begin
        fecha =  (params[:tciudadano]["fecha_nacimiento(3i)"]).to_s+
                 "/" + (params[:tciudadano]["fecha_nacimiento(2i)"]).to_s +
                 "/" + (params[:tciudadano]["fecha_nacimiento(1i)"]).to_s
        @fecha_nacimiento = fecha.to_date
      rescue
        return error_fecha
      end

      if( @nacionalidad == @ciudadano.dnacionalidad and
          @fecha_nacimiento == @ciudadano.ffecha_nac.to_date)

        if menor_edad?(@fecha_nacimiento)
          flash[:danger]=
              'El ciudadano debe ser mayor de edad '
          redirect_to action: 'nuevo_registro'
          return
        end

        construir_usuario

        @validatable = devise_mapping.validatable?
        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end

        respond_with self.resource
      else
        flash[:danger]=
            'Combinación de campos no Existente, verifique sus datos '
        redirect_to action: 'nuevo_registro'
      end
    end
  end


  def create
    # if verify_recaptcha
      original =  params[:session_user][:usuario_sput_attributes][:representante_legal_attributes][:rif]
      original_movil = params[:session_user][:usuario_sput_attributes][:movil]

      unless params[:session_user][:usuario_sput_attributes][:representante_legal_attributes][:rif].blank?
        params[:session_user][:usuario_sput_attributes][:representante_legal_attributes][:rif]=
            params[:session_user][:usuario_sput_attributes][:nacionalidad].to_s
        params[:session_user][:usuario_sput_attributes][:representante_legal_attributes][:rif]+=
            params[:session_user][:usuario_sput_attributes][:numero_doc].to_s
        params[:session_user][:usuario_sput_attributes][:representante_legal_attributes][:rif]+=
            original
      end

      unless original_movil.blank?
        params[:session_user][:usuario_sput_attributes][:movil]=
            params[:operadora] + original_movil
      end

      build_resource(sign_up_params)
      resource.password   = Devise.friendly_token.first(8)
      @carga_usuario_sput = UsuarioSput.find_by(numero_doc: resource.usuario_sput.numero_doc)

      unless @carga_usuario_sput.nil?

        resource.usuario_sput.id = @carga_usuario_sput.id
        @carga_usuario_sput.destroy

      end
      resource_saved =  resource.save

      yield resource if block_given?
      if resource_saved
        resource.usuario_sput.representante_legal.update_attributes(session_user_id: resource.id)
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)

        else
          expire_data_after_sign_in!
          @usuario_sput = resource.usuario_sput
          render 'session_users/registrations/later_register'
        end

      else
        resource.usuario_sput.representante_legal.rif = original
        resource.usuario_sput.movil = original_movil
        clean_up_passwords resource
        @validatable = devise_mapping.validatable?

        if @validatable
          @minimum_password_length = resource_class.password_length.min
        end

        respond_with resource
      end
    # else
    #
    #   build_resource(sign_up_params)
    #   clean_up_passwords(resource)
    #   resource.errors[:base] <<
    #       'Codigo de Verificación erróneo'
    #   render :new
    # end
  end


  def nuevo_registro
    if session_user_signed_in?
      flash[:danger] = 'Debe cerrar sesión para crear nuevo usuario'
      redirect_to root_path
    end
  end

  private

  def generar_lista
    @lista = {'E' => 'E',
              'V'=> 'V'}
    # @lista = @lista.sort si lista crece
  end

  def error_fecha
    flash[:danger]=
        'Fecha introducida en formato inválido'
    redirect_to action: 'nuevo_registro'
    return
  end

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(
          :operadora,
          :email,
          :email_confirmation,
          usuario_sput_attributes:[
              :nombre,:apellido,:movil,:nacionalidad,:numero_doc,
              :pregunta_secreta,:respuesta,:telefono_local,:correo_alterno,
              representante_legal_attributes:[
                  :cargo,:rif,:doc_rif,:doc_cedula,:doc_gaceta_naturalizacion,:direccion
              ]
          ]
      )
    }
  end

  def construir_usuario
    build_resource({})
    nombre   = concatenar_cadenas(@ciudadano.dnombre_1, @ciudadano.dnombre_2)
    apellido = concatenar_cadenas(@ciudadano.dapellido_1,@ciudadano.dapellido_2)

    if @usuario_sput_guardado.nil?
      usuario_sput = resource.build_usuario_sput( nombre: nombre ,
                                                  apellido: apellido,
                                                  numero_doc:
                                                      @ciudadano.ccedula,
                                                  nacionalidad:
                                                      @ciudadano.dnacionalidad
      )

    else
      usuario_sput = resource.build_usuario_sput(nombre: nombre ,
                                                 apellido: apellido,
                                                 numero_doc:
                                                     @ciudadano.ccedula,
                                                 nacionalidad:
                                                     @ciudadano.dnacionalidad,
                                                 telefono_local:
                                                     @usuario_sput_guardado.telefono_local,
                                                 movil:
                                                     @usuario_sput_guardado.movil,
                                                 correo_alterno:
                                                     @usuario_sput_guardado.correo_alterno,
                                                 pregunta_secreta:
                                                     @usuario_sput_guardado.pregunta_secreta,
                                                 respuesta:
                                                     @usuario_sput_guardado.respuesta
      )

    end
    usuario_sput.build_representante_legal
  end

  def concatenar_cadenas(cad1,cad2)
    if cad1.nil?
      if cad2.nil?
        return ''
      else
        return cad2
      end
    else
      if cad2.nil?
        return cad1
      else
        cad1 << ' '<< cad2
      end
    end
  end
end


