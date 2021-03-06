class EscuelaTransportes::SegurosController < ApplicationController
  include SolicitudConstruccionEscuelaHelper

  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion, only: [:new, :create]
  before_action :only_initial_solicitud, except:  :rif_aseguradora

  def new
    @seguro = @solicitud.seguro || Seguro.new
    if (not @solicitud.seguro_por_flota?) && @solicitud.seguro_por_vehiculo?
      redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id) and return
    end
    load_documentos(:rcv_flota, @seguro)
  end

  def create

    if (not @solicitud.seguro_por_flota?) && @solicitud.seguro_por_vehiculo?
      redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id) and return
    end

    flag, @seguro = @solicitud.seguro_update_or_create(seguro_params)
    respond_to do |format|
      if flag
         # DocumentosRequisitosPorVista.vista_completa?(:rcv_flota,@seguro)
         #  solicitud.update_index_mask(2)
          format.html { redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id), notice: 'Seguro RCV guardado exitosamente'  and return }
      else
        load_documentos(:rcv_flota, @seguro,true)
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
                                   :aseguradora_id, documentos_attributes: [:id, :documentos_requisitos_por_vista_id, :doc]) rescue nil
  end
end