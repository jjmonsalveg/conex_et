class EscuelaTransportes::PlanosInfraestructuraController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion
  before_action :cargar_representante
  helper_method :nombre_solicitud

  def new
    #TODO Arreglar el RIF de representante legal, o este rif
    @rif = @representante_legal.rif[0]
    @rif +='-'
    @rif += @representante_legal.rif[1..@representante_legal.rif.length-2]
    @rif +='-'
    @rif +=@representante_legal.rif[@representante_legal.rif.length-1]
    load_solicitud @escuela_transporte
  end

  def create
    init_solicitud(nombre_solicitud,@escuela_transporte)
    if @escuela_transporte.update(escuela_transporte_doc_params)
      @solicitud.update_index_mask(1)
      flash[:success]= 'Planos de la infraestructura cargados satisfactoriamente'
      # redirect_to escuela_transportes_cargar_planillas_path(@escuela_transporte)
      redirect_to root_path
    else
      load_documentos(nombre_vista,@solicitud,true)
      render :new
    end
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  def nombre_vista
    :planos_infraestructura
  end
  helper_method :nombre_vista

  private
  def cargar_representante
    @representante_legal =  current_session_user.representante_legal
  end

end
