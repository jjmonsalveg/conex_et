class EscuelaTransportes::VehiculosController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion , only: [:new, :create, :destroy,:index, :buscar_vehiculo_pre]

  def new
    if @escuela_transporte.nil?
      redirect_to escuela_transportes_informacion_general_index and return
    end
  end

  def buscar_vehiculo_pre
    if VehiculoPre.find_by(placa: ActionController::Parameters.new(placa: params[:placa]).permit(:placa)[:placa].upcase).nil?
      @vehiculo_intt = find_vehiculo_parametros
      render partial:'vehiculo_no_carga' and return if @vehiculo_intt.nil?
      @propietario = TramitePropietario.find_by(NRO_TRAMITE: @vehiculo_intt.NRO_TRAMITE) || TramitePropietario.new
      @vehiculo = VehiculoPre.new
      if @escuela_transporte.solicitud(nombre_solicitud).seguro.nil?
        seguro = @vehiculo.build_seguro
        @documentos_seguro = load_documentos(:rcv_flota, seguro, true)
      end
      @documentos_vehiculos = load_documentos(nombre_vista, @vehiculo)
      puts @documentos_vehiculos
      render partial: 'found_vehiculo'
    else
      render partial: 'vehiculo_in_use'
    end
  end

  #
  # def campos_documentos
  #   vehiculo_intt = find_vehiculo_parametros
  #   @vehiculo_et = VehiculoPre.build_vehiculo_intt(vehiculo_intt, @escuela_transporte.solicitud(nombre_solicitud))
  #   @documentos_vehiculos = load_documentos(:vehiculo_ensenanza, @vehiculo_et)
  #   render partial: 'campos_documentos'
  # end

  def create
    respond_to do |format|
      unless vehiculo_pertenece_et?
        vehiculo_intt = find_vehiculo_parametros
        if vehiculo_intt.present?
          @vehiculo = VehiculoPre.build_vehiculo_intt(vehiculo_intt, contrato_arrendamiento_params, create_vehiculo_documentos_params, @escuela_transporte.solicitud(nombre_solicitud))
          @vehiculo.build_documentos(create_vehiculo_documentos_params[:documentos_attributes])
          if @vehiculo.save
            @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(1)
            format.html { redirect_to escuela_transportes_vehiculos_path(id: @escuela_transporte.id),
                                      notice: 'El vehículo fue guardado con éxito.' }
          else
            format.html {redirect_to new_escuela_transportes_vehiculo_path(id: @escuela_transporte), alert: 'Error guardando el vehículo.' }
          end
        else
          format.html { redirect_to new_escuela_transportes_vehiculo_path(id: @escuela_transporte), alert: 'Vehículo no encontrado en base de datos INTT'}
        end
      else
        format.html { redirect_to new_escuela_transportes_vehiculo_path(id: @escuela_transporte), alert: 'Vehículo pertenece a otra Escuela de transporte'}
      end
    end
    # if vehiculo_pertenece_et?
    #   flash[:danger]=
    #   render js: "window.location = '#{new_escuela_transportes_vehiculo_path(id: @escuela_transporte)}'"
    # else
    #   vehiculo_intt = find_vehiculo_parametros
    #   if vehiculo_intt.nil?
    #     flash[:danger]=
    #     render js: "window.location = '#{}'"
    #   else
    #     @vehiculo_et = VehiculoPre.build_vehiculo_intt(vehiculo_intt, @escuela_transporte)
    #     @vehiculo_et.build_documentos(create_vehiculo_documentos_params[:documentos_attributes])
    #     respond_to do |format|
    #       if @vehiculo_et.save
    #         flash[:success]= 'Vehículo Guardado Satisfactoriamente'
    #         @escuela_transporte.solicitud(nombre_solicitud).update_index_mask(1)
    #         render js: "window.location = '#{escuela_transportes_vehiculos_path(id: @escuela_transporte)}'"
    #         return
    #       else
    #         load_documentos(nombre_vista,@vehiculo_et,true)
    #         format.js
    #       end
    #
    #     end
    #
    #   end
    # end
    #TODO hacer este if
    # if vehiculo_intt.ID_USO == 'CG' && !vehiculo_params[:certificado_homologacion].present?
  end

  def index
    @solicitud = @escuela_transporte.solicitud(nombre_solicitud)
  end

  def destroy
    @vehiculo  = @escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.find_by(placa: ActionController::Parameters.new(vh: params[:vh]).permit(:vh)[:vh])
    @vehiculo.destroy
    unless @escuela_transporte.solicitud(nombre_solicitud).vehiculo_pres.any?
      @escuela.solicitud(nombre_solicitud).update_index_mask(1, false)
    end
    flash[:success]= 'Vehículo eliminado con éxito'
    redirect_to escuela_transportes_vehiculos_path(id: @escuela) and return
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  def nombre_vista
    :vehiculo_pre
  end
  helper_method :nombre_vista


  private

  def find_vehiculo_parametros
    params[:placa] ||= params[:vehiculo_pre][:placa]
    params[:s_carroceria] ||=params[:vehiculo_pre][:s_carroceria]
    params[:ano] ||=params[:vehiculo_pre][:ano]

    TramiteVehiculo.find_by_placa_carroceria_ano(espacios_blancos_l_r(ActionController::Parameters.new(placa: params[:placa]).permit(:placa)[:placa]),
                                                 espacios_blancos_l_r(ActionController::Parameters.new(s_carroceria: params[:s_carroceria]).permit(:s_carroceria)[:s_carroceria]),
                                                 espacios_blancos_l_r(ActionController::Parameters.new(ano: params[:ano]).permit(:ano)[:ano]))
  end

  def params_id
    ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
  end

  helper_method :params_id

  def vehiculo_params
    params.require(:vehiculo_pre).permit(:placa, :s_carroceria, :ano, :certificado_registro, :certificado_homologacion, :rcv, :certificado_revision_tecnica, :bauche_vehiculo)
  end

  def placa_params
    params[:placa]||= params[:vehiculo_pre][:placa]
    placa_s = espacios_blancos_l_r (params[:placa])
    ActionController::Parameters.new(placa: placa_s.upcase).permit(:placa)[:placa]
  end

  def vehiculo_pertenece_et?
    VehiculoPre.find_by(placa: placa_params).present?
  end

  def create_vehiculo_documentos_params
    params.require(:vehiculo_pre).permit(:placa, :s_carroceria,:ano,:id,
                                         documentos_attributes:[:id, :documentos_requisitos_por_vista_id,:doc],
                                         seguro: [:rif,
                                                           :num_poliza,
                                                           :fecha_vencimiento,
                                                           :aseguradora_id,
                                                           :flotum_id,
                                                           :documento_poliza,
                                                           documentos_attributes: [
                                                               :id, :documentos_requisitos_por_vista_id, :doc]])
  end

  def contrato_arrendamiento_params
    params.require(:contrato_arrendamiento).permit(:duracion,
                                                   :fecha,
                                                   :tomo,
                                                   :folio,
                                                   :notaria,
                                                   :nombre_arrendatario,
                                                   :rif_arrendatario, :contrato_arrendamiento_file) rescue nil
  end
end
