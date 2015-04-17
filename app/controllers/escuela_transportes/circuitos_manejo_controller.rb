class EscuelaTransportes::CircuitosManejoController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion
  before_action :cargar_representante
  before_action :cargar_rif
  helper_method :nombre_solicitud
  helper_method :nombre_vista

  def index_circuitos
    init_solicitud(nombre_solicitud,@escuela_transporte)
  end

  def cargar_planillas
    init_solicitud(nombre_solicitud,@escuela_transporte)
    @solicitud.build_circuito if @solicitud.circuito.nil?
    @lista_documentos = load_documentos(nombre_vista,@solicitud.circuito,true)
    # {'E' => 'E',
    #  'V'=> 'V'}
    # = f.select :nacionalidad,  options_for_select(@lista, selected: 'V'),
    #            {id: 'select-documento'}, {class: 'form-control'}
  end

  def guardar_planillas

    # redirect_to escuela_transportes_cargar_planillas_path(@escuela_transporte),
    #             alert: 'Debe cargar algun documento' and return if params[:documento].blank?
    #
    # solicitud = @escuela_transporte.solicitud(:preinscripcion)
    # documentoRequisito = DocumentoRequisito.find_by(nombre: :planillas_practicas_manejo)
    #
    # @documento = solicitud.documentos.build(params_planillas)
    # @documento.documento_requisito = documentoRequisito
    # @documento.solicitud = solicitud
    #
    #
    # if @documento.save
    #   @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(3)
    #   flash[:success]= 'Planilla cargada satisfactoriamente'
    #   redirect_to escuela_transportes_cargar_planillas_path(@escuela_transporte)
    # else
    #   flash[:danger] = 'Error cargando la planilla'
    #   render 'escuela_transportes/planillas_practica_manejo/cargar_planillas'
    # end

  end
  #
  # def eliminar_planilla
  #
  #   Documento.find_by(id: params_id_planilla).destroy
  #   flash[:success] = 'Planilla Eliminada con exito'
  #
  #   @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(3,false) if @escuela_transporte.documentos_planillas.empty?
  #   redirect_to escuela_transportes_cargar_planillas_path(@escuela_transporte)
  #
  # end

  def nombre_solicitud
    :preinscripcion
  end

  def nombre_vista
    :registro_circuitos_manejo
  end

  private

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

  def params_planillas
    params.require(:documento).permit(:nombre,:doc)
  end

  def params_id_planilla
    ActionController::Parameters.new(id_planilla: params[:id_planilla]).permit(:id_planilla)[:id_planilla]
  end

end
