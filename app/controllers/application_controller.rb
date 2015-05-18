class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #TODO descomentar vencimiento del rif
  include ApplicationHelper
  include SessionUsersHelper
  include ManageSolicitudHelper
  include ManageDocumentHelper
  helper_method :resource, :resource_name, :devise_mapping

  protect_from_forgery with: :exception
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'Usted no esta autorizado para acceder a la página solicitada.'
    redirect_to root_path
  end

  def resource_name
    current_usuario.class.name.underscore.downcase.to_sym
  end

  def resource
    if session_user_signed_in?
      @resource ||= SessionUser.new
    elsif funcionario_signed_in?
      @resource ||= Funcionario.new
    end
  end

  def devise_mapping
    if session_user_signed_in?
      @devise_mapping ||= Devise.mappings[:session_user]
    elsif funcionario_signed_in?
      @devise_mapping ||= Devise.mappings[:funcionario]
    end
  end


  def generate_barcodes(data)
    require 'barby'
    require 'barby/barcode/code_128'
    require 'barby/outputter/png_outputter'
    uri = CGI.escape('Code128B') + '_' + CGI.escape(data) + '.png'
    fname =  Rails.root.join('public/Barcodes/' + uri)

    unless File.exists?(fname)
      str = 'Barby::Code128B'+'.new("'+data+'")'
      begin
        barcode = eval str
      rescue Exception => exc
        barcode = Barby::Code128B.new(data)
      end
      File.open(fname, 'w'){|f|
        f.write barcode.to_png(height: 40, margin: 5)
      }
    end
  end


  ########################################################################################
  ########################################################################################
  ########################################################################################

  protected

  def autenticar_session_user!
    if funcionario_signed_in?
      sign_out current_funcionario
    end
    authenticate_session_user!
  end

  def autenticar_funcionario!
    if session_user_signed_in?
      sign_out current_session_user
    end
    authenticate_funcionario!
  end
  def self.funcion_sistema
    self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
  end

  def current_ability
    @current_ability ||= Ability.new(current_funcionario)
  end

  def cargar_permisos
    @current_permisos =
        current_funcionario.rols.each do |rol|
          rol.funcion_sistemas.collect do
          |i| [i.clase_controlador, i.accion]
          end
        end
  end

  def set_escuela_transporte_preinscripcion
    @escuela_transporte = current_session_user.escuela_transportes.find_by(id: params_id)
    ## Si la escuela de transporte no pertenece al representante legal presente o ya la solicitud esta bloqueada
    if @escuela_transporte.nil? || @escuela_transporte.solicitud(nombre_solicitud).locked
      redirect_to root_path and return
      ## Si no termino la carga de los documentos del registro
    elsif not DocumentosRequisitosPorVista.vista_completa?(:registro_inicial,@escuela_transporte)
      redirect_to new_escuela_transportes_documentos_registro_path(id: @escuela_transporte), alert: 'Debe terminar el registro de la Escuela de Transporte.' and return
      # SI tiene el RIF vencido
    elsif @escuela_transporte.fecha_vencimiento_rif < Date.today
      redirect_to edit_escuela_transportes_update_rif_path(id: @escuela_transporte), alert: 'Esta Escuela de Transporte posee el RIF vencido, por favor actualizarlo.' and return
    end
  end


  #el representante legal solo puede acceder a su informacion
  def redirect_root_with_flash_message(message='')
    flash[:danger]= message
    redirect_to root_path
  end

  #configuracion de Strong Parameters
  def params_id
    ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
  end

  # ########################################################
  # ########## PARAMETROS PARA GUARDAR DOCUMENTOS ##########
  # ########################################################
  def escuela_transporte_doc_params
    params.require(:escuela_transporte).permit(solicituds_attributes: [ :id,
                                                                        documentos_attributes:
                                                                            [:id, :documentos_requisitos_por_vista_id,
                                                                             :doc
                                                                            ]
                                               ]
    )
  end
end

