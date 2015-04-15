class EscuelaTransportes::EscuelaTransportesController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_representante_legal
  before_action :verificar_usuario
  before_action :set_escuela_transporte , only: [:show, :edit, :update, :destroy]
  before_action :generar_lista_operadoras_movil, only: [:create,:new,:edit,:update]
  before_action :escuela_locked, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @escuela_transportes =
        EscuelaTransporte.where(representante_legal_id: @representante_legal.id)
    respond_with(@escuela_transportes)
  end

  def show
    respond_with(@escuela_transporte)
  end

  def new
    @escuela_transporte = EscuelaTransporte.new
    cargar_movil
    respond_with(@escuela_transporte)
  end

  def edit
    cargar_movil(@escuela_transporte)
  end

  def create
    @escuela_transporte =
        @representante_legal.escuela_transportes.build(escuela_transporte_params)

    @original_movil = set_movil_for_save(@escuela_transporte)
    if @escuela_transporte.save
      flash[:success]= 'Datos de Escuela de Transporte guardados con éxito'
      redirect_to escuela_transportes_cargar_documentos_registro_path(id: @escuela_transporte) and return
    else
      restart_movil_view(@original_movil , @escuela_transporte)
      render :new
    end
  end

  def update
    original_movil = set_movil_for_update(@escuela_transporte)
    if @escuela_transporte.update(escuela_transporte_params)
      flash[:success]= 'Escuela de transporte actualizada con éxito'
      flash[:alert]= 'Si tiene planillas activas recuerde actualizarlas'
      redirect_to escuela_transportes_cargar_documentos_registro_path(id: @escuela_transporte)
      return
    else
      restart_movil_view(original_movil , @escuela_transporte)
      render :new
    end
  end

  def destroy
    @escuela_transporte.destroy
    flash[:success]= 'Escuela de transporte Eliminada con éxito'
    redirect_to representante_legal_escuela_transportes_path(current_session_user) and return
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
  def escuela_locked
    if @escuela_transporte.solicituds_lockeds.any?
      redirect_to root_path, alert: 'No puede editar la Escuela de Transporte.' and return
    end
  end

  def verificar_usuario
    begin
      current_usuario.id
      if current_usuario.id != @representante_legal.id
        raise
      end
    rescue
      redirect_root_with_flash_message('No puede acceder a información privada')
    end

  end


  def set_escuela_transporte
    begin
      @escuela_transporte  = @representante_legal.escuela_transportes.find_by(id: params_id)
      raise if @escuela_transporte.nil?
    rescue
      redirect_root_with_flash_message('Escuela de transporte no le pertenece o no existe')
    end

  end

  def set_representante_legal
    @representante_legal = RepresentanteLegal.find_by(id: params[:representante_legal_id])
  end

  def escuela_transporte_params
    params.require(:escuela_transporte).permit(:razonSocial, :nombre_comercial, :rif, :fecha_vencimiento_rif,
                                               :email, :telefono, :movil, :avenida, :calle,
                                               :urbanizacion,:edificio_cc, :local, :piso,
                                               :url, :ciudad_id, :parroquia_id,
                                               :representante_legal_id, :tipo_rif, :digito_rif


    )
  end
end
