class InteresadoCets::InteresadoCetsController < ApplicationController
  before_filter :autenticar_funcionario!
  load_and_authorize_resource
  before_filter :cargar_permisos

  before_action :set_interesado_cet, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @nro_interesados = InteresadoCet.all.count
    respond_with(@interesado_cets)
  end

  def show
    respond_with(@interesado_cet)
  end

  def new
    @interesado_cet = InteresadoCet.new
    respond_with(@interesado_cet)
  end

  # def edit
  # end

  def create
    @interesado_cet = InteresadoCet.new_registro(interesado_cet_params)
    respond_with(@interesado_cet)
  end

  def update
    @interesado_cet.update(interesado_cet_params)
    @interesado_cet.update_column(:nro_consultas, @interesado_cet.nro_consultas + 1 )
    respond_with(@interesado_cet)
  end

  # def destroy
  #   @interesado_cet.destroy
  #   respond_with(@interesado_cet)
  # end

  def find_interesado_ajax
    @interesado_cet =  InteresadoCet.find_by_cedula(cedula_ajax)  || InteresadoCet.find_in_saime(cedula_ajax)
    render partial: 'interesado'
  end

  private
    def set_interesado_cet
      @interesado_cet = InteresadoCet.find(params[:id])
    end

    def interesado_cet_params
      params.require(:interesado_cet).permit(:telefono, :email, :ciudad_id, :municipio_id, :telefono, :cedula, :tipo_escuela_id)
    end

    def cedula_ajax
      ActionController::Parameters.new(cedula: params[:cedula]).permit(:cedula)[:cedula]
    end

    def self.funcion_sistema
      return "InteresadoCet"
    end

end
