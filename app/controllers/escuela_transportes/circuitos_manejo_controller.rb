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
      @guardo = @solicitud.update(params_solicitud_circuito)
      flash[:success]='Circuito de manejo Guardado exitosamente, a continuacion suba los siguientes documentos' if @guardo
      @circuito =  @solicitud.circuitos.last
      format.js
    end
  end

  def guardar_documentos_circuito
    @circuito =  Circuito.includes(:solicitud).find_by(id: params[:id])
    check_circuito
    @escuela_transporte= @representante_legal.escuela_transportes.joins(solicituds: :circuitos).where(circuitos: {id: @circuito.id} ).last

    if @escuela_transporte.nil?
      redirect_to root_path
      return
    end

    if @circuito.documentos_registro_circuito_completos?
      flash[:success]= 'Documentos de Circuito Guardados Satisfactoriamente'
      redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
      return
    else
      flash[:danger]= 'Debe cargar los Documentos Paginados, intente denuevo '
      redirect_to escuela_transportes_editar_circuito_path(id:@escuela_transporte, circuito_id: @circuito)
    end
  end

  def actualizar_circuito
    @circuito =  @solicitud.circuitos.find_by(id:params[:solicitud][:circuitos_attributes]['0'][:id])
    p @circuito
    check_circuito
    if @solicitud.update(params_solicitud_circuito)
      if @circuito.documentos_registro_circuito_completos?

        flash[:success]='Circuito de manejo Guardado exitosamente'
        redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
      else
        flash[:danger]= 'Debe cargar los Documentos Paginados, intente denuevo '
        redirect_to escuela_transportes_editar_circuito_path(id:@escuela_transporte, circuito_id: @circuito)
      end
    else
      render'escuela_transportes/circuitos_manejo/editar_circuito', url: escuela_transportes_actualizar_circuito_path, method: :patch
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
        flash[:danger]='Solicitud no le pertenece a ninguna de sus Escuelas'
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
    params.require(:solicitud).permit(:id,circuitos_attributes: [:id,:tipo_circuito,:descripcion_ruta,
                                                                 documentos_attributes:
                                                                     [:id, :documentos_requisitos_por_vista_id,:doc]
                                         ])
  end

  def params_circuito_documento
    params.require(:circuito).permit(:id,documentos_attributes: [:id, :documentos_requisitos_por_vista_id,:doc])
  end
end
