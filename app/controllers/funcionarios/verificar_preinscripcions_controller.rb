class Funcionarios::VerificarPreinscripcionsController < ApplicationController
  before_filter :autenticar_funcionario!
  authorize_resource class: :verificar_preinscripcion
  before_action :cargar_permisos
  before_action :set_solicitud, except: [:index,:wf_buscar_solicitud]
  before_action :block_solicitud, except: [:index,:wf_buscar_solicitud,
                                           :wf_solitud_procesada]

  #Listar y buscar solicitudes
  def index
  end

  def wf_buscar_solicitud
    @solicitud = Solicitud.includes(:servicio_intt).joins(:tipo_solicitud).where(id: query,
                                                                                 tipo_solicituds: {
                                                                                     nombre: nombre_solicitud
                                                                                 } ).last
    render partial: 'found_solicitud'
  end

  #Paginas del Wizard
  def wf_verificar_informacion_general
  end

  def wf_verificar_planos
  end

  def wf_verificar_rcv_flota
  end

  def wf_verificar_vehiculos
    @vehiculos = VehiculoPre.includes(:documentos,:seguro,:contrato_arrendamiento)
                     .where(solicitud_id:@solicitud)
                     .order(id: :asc).paginate(page: params[:page] , per_page: 5)
  end

  def wf_verificar_circuitos_manejo
    @circuitos = Circuito.includes(:documentos).where(solicitud_id: @solicitud)
                     .order(id: :asc).paginate(page: params[:page] , per_page: 5)
  end

  def wf_verificar_trabajadores
    @trabajadores = Personal.includes(:documentos).where(solicitud_id: @solicitud)
                        .order(id: :asc).paginate(page: params[:page] , per_page: 5)

  end
  #Acciones tomadas sobre la solicitud
  def wf_diferir_solicitud
    establecer_nuevo_estado(:diferida)
  end


  def wf_realizar_inspeccion
    establecer_nuevo_estado(:en_espera_de_inpeccion)
  end

  def wf_realizar_estudio
    establecer_nuevo_estado(:para_estudio)
  end

  def wf_cancelar_inspeccion
    @solicitud.unlock!
    redirect_to verificar_preinscripcions_path
  end

  def wf_solitud_procesada
    @info = @solicitud.informacion_traza_verificacion_preinscripcion
  end

  private

  def establecer_nuevo_estado(state)
    Solicitud.transaction do
      block_solicitud

      if params[:observacion].blank? and state == :rechazada
        flash[:danger]='El campo observación es obligatorio'
        redirect_to verificar_informacion_general_path(@solicitud.id)
      else
        initial_status = @solicitud.status
        @solicitud.status = state
        if @solicitud.save!
          array_status =Solicitud.statuses
          TrazaSolicitudFuncionario.create!(
              solicitud_id: @solicitud.id,
              funcionario_id:current_usuario.id,
              observacion: params[:observacion],
              estado_inicial: array_status[initial_status.to_sym],
              estado_final:   array_status[@solicitud.status.to_sym],
              ip_funcionario: current_usuario.current_sign_in_ip

          )
          flash[:success]= "Solicitud cuyo numero de tramite es #{@solicitud.id} esta #{state.to_s.humanize} satisfactoriamente"
          redirect_to verificar_preinscripcions_path
        else
          flash[:danger]= "Solicitud cuyo numero de tramite es #{@solicitud.id} no fue modificada de Estado Error del sistema"
          redirect_to verificar_preinscripcions_path
        end
      end
    end
  end


  def block_solicitud
    if @solicitud.estado?(:initial)
      flash[:danger]= 'Solicitud de Autorización de adecuación con este numero aún no puede ser verificada'
      redirect_to verificar_preinscripcions_path
    elsif not ( @solicitud.estado?(:registrada) or @solicitud.estado?(:diferida) )
      redirect_to verificada_path(@solicitud)
    elsif @solicitud.estado?(:registrada) or @solicitud.estado?(:diferida)
      @solicitud.lock!
    end
  end

  def self.funcion_sistema
    :verificar_preinscripcion
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method 'nombre_solicitud'

  def query
    ActionController::Parameters.new(query: params[:query]).permit(:query)[:query]
  end

  def set_solicitud
    @solicitud = Solicitud.joins(:tipo_solicitud).where(id: params_id,tipo_solicituds:{nombre: :preinscripcion}).last
    if @solicitud.nil?
      flash[:danger]= 'No existe una Solicitud de Autorización de adecuación con este numero de Tramite'
      redirect_to verificar_preinscripcions_path
    end
  end

  def rechazar_params
    params.permit(:observacion)
  end
end
