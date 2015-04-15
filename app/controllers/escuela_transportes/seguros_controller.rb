class EscuelaTransportes::SegurosController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion

  def new
    @seguro_vehiculo = @escuela_transporte.solicitud(:preinscripcion).seguro_vehiculo || SeguroVehiculo.new
    load_documentos(:rcv_flota, @seguro_vehiculo)
    puts @documentos
  end

end