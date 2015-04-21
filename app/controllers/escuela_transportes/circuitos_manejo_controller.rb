class EscuelaTransportes::CircuitosManejoController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion,only:[:index_circuitos, :new, :editar_circuito]
  before_action :cargar_representante
  before_action :cargar_rif
  before_action :cargar_solicitud_escuela, only: [:actualizar_circuito,:guardar_circuito,:show]
  helper_method :nombre_solicitud
  helper_method :nombre_vista
  helper_method :reload_documents?

  def index_circuitos
    init_solicitud(nombre_solicitud,@escuela_transporte)
  end

  def new
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @circuito = @solicitud.circuitos.build
  end

  def show
  end

  def editar_circuito
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @circuito = @solicitud.circuitos.find_by(id: params[:circuito_id])
    check_circuito
  end

  def guardar_circuito
    respond_to do |format|
      if @solicitud.update(params_solicitud_circuito)
        flash[:success]='Circuito de manejo Guardado exitosamente'
        @guardo = true
      else
        @guardo = false
        # render 'escuela_transportes/circuitos_manejo/new', url: escuela_transportes_guardar_circuito_path(@solicitud), method: :post
      end
      @circuito =  @solicitud.circuitos.last
      format.js
    end
  end

  # def guardar_circuito
  #   # respond_to do |format|
  #   #
  #   # end
  #   if @solicitud.update(params_solicitud_circuito)
  #     flash[:success]='Circuito de manejo Guardado exitosamente'
  #     redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
  #   else
  #     @circuito =  @solicitud.circuitos.last
  #     render 'escuela_transportes/circuitos_manejo/new', url: escuela_transportes_guardar_circuito_path(@solicitud), method: :post
  #   end
  # end

  def actualizar_circuito
    if @solicitud.update(params_solicitud_circuito)
      flash[:success]='Circuito de manejo Guardado exitosamente'
      redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
    else
      @circuito =  @solicitud.circuitos.find_by(id: params[:solicitud][:circuitos_attributes][:id])
      render'escuela_transportes/circuitos_manejo/editar_circuito', url: escuela_transportes_actualizar_circuito_path(@solicitud), method: :patch
    end
  end


  def eliminar_circuito
    circuito= Circuito.includes(:solicitud).find_by(id: params[:id])
    if circuito.present?
      escuela = @representante_legal.escuela_transportes.joins(:solicituds).where(solicituds:{id: circuito.solicitud.id}).last
      if  escuela.nil?
        flash[:danger] = 'Este circuito no existe para ninguna de sus Escuelas'
        redirect_to root_path
      else
        circuito.destroy
        flash[:success] = 'Circuito de Manejo Eliminado con exito'
        redirect_to escuela_transportes_index_circuitos_path(id: escuela.id)
      end
    else
      flash[:danger] = 'Este circuito no existe'
      redirect_to root_path
    end
  end

  def nombre_solicitud
    :preinscripcion
  end

  def nombre_vista
    :registro_circuitos_manejo
  end

  def reload_documents?
    not (action_name == 'new' or action_name == 'editar_circuito')
  end

  private

  def check_circuito
    if @circuito.nil?
      flash[:danger]='Circuito No existente'
      redirect_to root_path
    end
  end
  def cargar_solicitud_escuela
    @solicitud = Solicitud.includes(:servicio_intt).find_by(id: params[:id])
    if @solicitud.nil? or (not @solicitud.servicio_intt_type == 'EscuelaTransporte')
      flash[:danger]='Solicitud no Existente'
      redirect_to root_path
    else
      @escuela_transporte = @representante_legal.escuela_transportes.find_by(id:@solicitud.servicio_intt.id)
      if @escuela_transporte.nil?
        flash[:danger]='Solicitud no le pertenece a ninguna de sus escuelas'
        redirect_to root_path
      end
    end
  end

  def cargar_rif
    #TODO Arreglar el RIF de representante legal, o este rif
    @rif = @representante_legal.rif[0]
    @rif +='-'
    @rif += @representante_legal.rif[1..@representante_legal.rif.length-2]
    @rif +='-'
    @rif +=@representante_legal.rif[@representante_legal.rif.length-1]
  end

  def cargar_representante
    @representante_legal =  current_session_user.representante_legal
  end

  def params_solicitud_circuito
    params.require(:solicitud).permit(:id,circuitos_attributes: [:id,:tipo_circuito,:descripcion_ruta])
  end

  def params_id_planilla
    ActionController::Parameters.new(id_planilla: params[:id_planilla]).permit(:id_planilla)[:id_planilla]
  end

end
