 class EscuelaTransportes::SegurosController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion, only: [:new, :create]
  before_action :check_seguro_solicitud, only: [:create]

  def new
    @seguro = @escuela_transporte.solicitud(nombre_solicitud).seguro || Seguro.new
    if @seguro.solicitud.nil? && @escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.any?
      if @escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.first.seguro.present? ||
          @escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.last.seguro.present?
        redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id) and return
      end
    end
    load_documentos(:rcv_flota, @seguro)
  end

  def create
    flag, @seguro = @escuela_transporte.solicitud(nombre_solicitud).seguro_update_or_create(seguro_params)
    respond_to do |format|
      if flag
        format.html { redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id), notice: 'Seguro RCV guardado exitosamente'  and return }
      else
        format.html { render :new }
      end
    end
  end

  def rif_aseguradora
    render json: [params[:id].blank? ? "" : Aseguradora.find_by(id: params[:id]).rif]
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  private
    def seguro_params
    params.require(:seguro).permit(:rif, :num_poliza, :fecha_vencimiento,
                                     :aseguradora_id, documentos_attributes: [:id, :documentos_requisitos_por_vista_id, :doc])
    end

    def check_seguro_solicitud
      unless seguro_params.present? && !@escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.any?
        redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id) and return
      end
    end
end