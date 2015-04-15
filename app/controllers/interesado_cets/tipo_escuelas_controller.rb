class InteresadoCets::TipoEscuelasController < ApplicationController
  before_filter :autenticar_funcionario!
  load_and_authorize_resource
  before_filter :cargar_permisos

  before_action :set_tipo_escuela, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @tipo_escuelas = TipoEscuela.all
    respond_with(@tipo_escuelas)
  end

  def show
    respond_with(@tipo_escuela)
  end

  def new
    @tipo_escuela = TipoEscuela.new
    respond_with(@tipo_escuela)
  end

  def edit
  end

  def create
    @tipo_escuela = TipoEscuela.new(tipo_escuela_params)
    @tipo_escuela.save
    respond_with(@tipo_escuela)
  end

  def update
    @tipo_escuela.update(tipo_escuela_params)
    respond_with(@tipo_escuela)
  end

  def destroy
    @tipo_escuela.destroy
    respond_with(@tipo_escuela)
  end

  private
    def set_tipo_escuela
      @tipo_escuela = TipoEscuela.find(params[:id])
    end

    def tipo_escuela_params
      params.require(:tipo_escuela).permit(:nombre)
    end

    def self.funcion_sistema
      return "TipoEscuela"
    end
end
