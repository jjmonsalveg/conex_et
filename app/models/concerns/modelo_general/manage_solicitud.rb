module ModeloGeneral
  module ManageSolicitud

    #Para cualquier servicio Intt poder consultar una solicitud sabiendo su nombre
    def solicitud(nombre_solicitud)
      self.solicituds.joins(:tipo_solicitud).find_by(tipo_solicituds: {nombre: nombre_solicitud})
    end

  end
end