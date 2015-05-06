class EscuelaTransportes::InformacionGeneralController < ApplicationController

  include SolicitudConstruccionEscuelaHelper

  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion , only: [:new_get, :update]
  before_action :check_info, only: [:new]
  before_action :check_list_registradas , only: :index


  def index
  end

  def new
    @escuela_transporte = EscuelaTransporte.find_by(id: info_params[:escuela])
    only_creada_solicitud
    @escuela_transporte.update_column(:tipo_escuela_id, TipoEscuela.find_by(id: info_params[:tipo_escuela]))
    @escuela_transporte.tipo_escuela = TipoEscuela.find_by(id: info_params[:tipo_escuela])
    load_solicitud @escuela_transporte
  end

  def update
    respond_to do |format|
      init_solicitud(nombre_solicitud,@escuela_transporte)
      only_creada_solicitud

      if @escuela_transporte.update(escuela_transporte_doc_params) and @escuela_transporte.documento_requisito_paginados_completos?(nombre_vista,@solicitud)
        format.html { redirect_to escuela_transportes_cargar_planos_path(id: @escuela_transporte),
                                  notice: 'Se ha actualizado la Información General de la escuela de transporte satisfactoriamente.' }

      else
        @lista_documentos =  load_documentos(nombre_vista,@solicitud,true)
        format.html { render :new }
        format.json { render json: @tramite.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_get
    load_solicitud @escuela_transporte
    only_creada_solicitud

    @representante_legal = current_session_user.representante_legal
    render template: 'escuela_transportes/informacion_general/new' if @solicitud.estado?(:creada)
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  def nombre_vista
    :informacion_general
  end
  helper_method :nombre_vista

  private

  def check_list_registradas
    if current_session_user.escuelas_registradas.empty?
      flash[:warning] = 'No posee escuelas registradas en el sistema para poder Preinscribirlas'
      redirect_to root_path
    end
  end

  def info_params
    params.require(:info).permit(:escuela, :tipo_escuela)
  end

  def check_info
    if info_params[:escuela].blank? && info_params[:tipo_escuela].blank?
      redirect_to escuela_transportes_informacion_general_index_path,
                  alert: "Debe seleccionar una Escuela de Transporte y un Tipo de Escuela." and return
    end
  end

end