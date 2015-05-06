module SolicitudConstruccionEscuelaHelper
  def only_creada_solicitud
    init_solicitud(nombre_solicitud, @escuela_transporte)
    unless @solicitud.estado?(:creada)
      flash[:danger] = 'Debe Modificar datos de solicitud para ejecutar esta acción (haga click en Modificar)'
      redirect_to escuela_transportes_informacion_general_index_path and return
    end
  end


  ## METODO PARA REDIRECCIONAR EL USUARIO EN EL
  ## GRUPO DE REQUISITOS FALTANTE PARA LA SOLICITUD PREINSCRIPCION
  def route_completar_adecuacion_construccion
    if not DocumentosRequisitosPorVista.vista_completa?(:informacion_general,@solicitud)
      escuela_transportes_informacion_general_new_get_path(id: @escuela_transporte)
    elsif not DocumentosRequisitosPorVista.vista_completa?(:planos_infraestructura,@solicitud)
      escuela_transportes_cargar_planos_path(id: @escuela_transporte)
    elsif @solicitud.seguro_nil? or ( @solicitud.seguro_por_flota? and (not DocumentosRequisitosPorVista.vista_completa?(:rcv_flota,@solicitud.seguro) ) )
      new_escuela_transportes_seguro_path(id: @escuela_transporte)
    elsif @solicitud.vehiculo_pres.empty? or vehiculos_incompletos?
      escuela_transportes_vehiculos_path(id:@escuela_transporte)
    elsif @solicitud.circuitos.empty? or circuitos_incompletos?
      escuela_transportes_index_circuitos_path(id: @escuela_transporte)
    elsif @solicitud.personals.empty? or personal_incompleto?
      escuela_transportes_listar_personals_path(id: @escuela_transporte)
    else
      nil #todo OK
    end
  end

  def vehiculos_incompletos?

    @solicitud.vehiculo_pres.each do  |vehiculo|
      unless DocumentosRequisitosPorVista.vista_completa?(:vehiculo_pre,vehiculo)
        return true
      end
    end
    false
  end

  def personal_incompleto?
    @solicitud.personals.each do  |personal|
      unless personal.documentos_registro_completos?
        return true
      end
    end
    false
  end

  def circuitos_incompletos?
    @solicitud.circuitos.each  do  |circuito|
      unless circuito.documentos_registro_circuito_completos?
        return true
      end
    end
    false
  end

end
