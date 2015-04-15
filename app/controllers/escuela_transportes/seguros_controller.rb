 class EscuelaTransportes::SegurosController < ApplicationController
  before_filter :autenticar_session_user!
  before_action :autorized_user
  before_action :set_escuela_transporte_preinscripcion, only: [:new, :create]

  def new
    @seguro = @escuela_transporte.solicitud(nombre_solicitud).seguro || Seguro.new
    load_documentos(:rcv_flota, @seguro)
  end

  def create

  end

  def rif_aseguradora
    render json: [params[:id].blank? ? "" : Aseguradora.find_by(id: params[:id]).rif]
  end

  def nombre_solicitud
    :preinscripcion
  end
  helper_method :nombre_solicitud

  private
   def seguro_params

   end
end