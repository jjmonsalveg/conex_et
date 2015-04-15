class EscuelaTransportes::DocumentosRegistrosController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte

  def new
    load_documentos(:registro_inicial, @escuela_transporte)
  end

  def create
    if @escuela_transporte.update(escuela_transporte_doc_params) and @escuela_transporte.documento_requisito_paginados_completos?(nombre_vista,@escuela_transporte)
      flash[:success]= 'Documentos registrados con éxito'
      redirect_to representante_legal_escuela_transportes_path(@escuela_transporte.representante_legal) and return
    else
      load_documentos(:registro_inicial, @escuela_transporte,true)
      render :new
    end
  end

  def index
  end

  def nombre_solicitud
    :registro_escuela_transporte
  end
  helper_method :nombre_solicitud

  def nombre_vista
    :registro_inicial
  end
  helper_method :nombre_vista

  private
  def set_escuela_transporte
    @escuela_transporte  = current_session_user.representante_legal.escuela_transportes.find_by(id: params_id)
  end

  def escuela_transporte_doc_params
    params.require(:escuela_transporte).permit(:id,documentos_attributes:[:id, :documentos_requisitos_por_vista_id,:doc])
  end
end