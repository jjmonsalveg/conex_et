class CaducarSolicitudPreinscripcionJob < ActiveJob::Base
  queue_as :default

  def perform(solicitud)
    solicitud.procesar_evento!(:caducar)
  end
end
