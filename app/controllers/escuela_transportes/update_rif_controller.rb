class EscuelaTransportes::UpdateRifController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte

  def edit
    @lista_documentos= load_documentos(:registro_inicial, @escuela_transporte)
  end

  def update
    if @escuela_transporte.update(update_rif_params)
      flash[:success]= 'RIF actualizado con éxito'
      redirect_to representante_legal_escuela_transportes_path(@escuela_transporte.representante_legal) and return
    else
      @lista_documentos= load_documentos(:registro_inicial, @escuela_transporte,true)
      restart_movil_view(original_movil , @escuela_transporte)
      render :edit
    end
  end

  def nombre_solicitud
    :registro_escuela_transporte
  end
  helper_method :nombre_solicitud

  def nombre_tramite
    :registro_inicial
  end
  helper_method :nombre_tramite

  private
  def set_escuela_transporte
    @escuela_transporte = current_session_user.escuela_transportes.find_by(id: params_id)
    if @escuela_transporte.nil?
      redirect_to root_path
    end
  end

  def update_rif_params
    params.require(:escuela_transporte).permit(:fecha_vencimiento_rif,
                                               documentos_attributes:[:id, :documentos_requisitos_por_vista_id,:doc])
  end
end