class EscuelaTransportes::CircuitosManejoController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion
  before_action :cargar_representante
  before_action :cargar_rif
  before_action :cargar_solicitud, only: [:actualizar_circuito,:guardar_circuito]
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

  def editar_circuito
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @circuito = @solicitud.circuitos.find_by(id: params[:circuito_id])
  end

  def guardar_circuito
    if @solicitud.update(params_solicitud_circuito)
      flash[:success]='Circuito de manejo Guardado exitosamente'
      redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
    else
      @circuito =  @solicitud.circuitos.last
      render 'circuito_form', url: escuela_transportes_guardar_circuito_path(@escuela_transporte), method: :post
    end
  end

  def actualizar_circuito
    if @solicitud.update(params_solicitud_circuito)
      flash[:success]='Circuito de manejo Guardado exitosamente'
      redirect_to escuela_transportes_index_circuitos_path(id: @escuela_transporte.id)
    else
      @circuito =  @solicitud.circuitos.find_by(id: params[:solicitud][:circuitos_attributes][:id])
      render 'circuito_form', url: escuela_transportes_actualizar_circuito_path(@escuela_transporte), method: :patch
    end
  end


  def eliminar_circuito

    Documento.find_by(id: params_id_planilla).destroy
    flash[:success] = 'Planilla Eliminada con exito'

    @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(3,false) if @escuela_transporte.documentos_planillas.empty?
    redirect_to escuela_transportes_cargar_planillas_path(@escuela_transporte)

  end

  def nombre_solicitud
    :preinscripcion
  end

  def nombre_vista
    :registro_circuitos_manejo
  end

  def reload_documents?
    not (action_name == 'new' or action_name == 'index_circuitos')
  end

  private
  def cargar_solicitud
    @solicitud = @escuela_transporte.solicituds.find_by(id: params[:id])
    if @solicitud.nil?
      flash[:danger]='Solicitud no Existente'
      redirect_to root_path
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
