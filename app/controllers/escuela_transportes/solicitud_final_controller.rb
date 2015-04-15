class EscuelaTransportes::SolicitudFinalController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_and_solicitud
  before_action :check_solicitud_completa

  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/png_outputter'

  def new
    if @solicitud.preparada? || @solicitud.modificada?
      @solicitud.update(planilla_time: DateTime.now, numero_planilla: NumeroControl.set_last('solicitud').numero, status: Solicitud.statuses[:completa])
    end
    generate_barcodes(@solicitud.numero_planilla.to_s)
  end

  def print
    respond_to do |format|
      format.pdf do
        pdf = SolicitudReport.new(@escuela_transporte, @solicitud, :page_size => "LETTER")
        send_data pdf.render, filename: "solicitud_final.pdf", type: 'application/pdf'
      end
    end
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  private
    def set_escuela_transporte_and_solicitud
      @escuela_transporte = current_session_user.escuela_transportes.find_by(id: params_id)
      @solicitud = @escuela_transporte.solicitud(nombre_solicitud)
    end

    def params_id
      ActionController::Parameters.new(id: params[:id]).permit(:id)[:id]
    end

    def check_solicitud_completa
      redirect_to grupo_requisito_faltante(@solicitud), alert: 'Debe de completar la Solicitud' and return unless @escuela_transporte.solicitud(nombre_solicitud).completa? || @escuela_transporte.solicitud(nombre_solicitud).preparada? || @escuela_transporte.solicitud(nombre_solicitud).modificada?
    end
end