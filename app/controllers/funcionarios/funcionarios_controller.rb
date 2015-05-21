class Funcionarios::FuncionariosController < ApplicationController
  before_filter :autenticar_funcionario!
  def get_info
    if Funcionario.find_by_cedula(params[:cedula]).nil?
      @funcionario = Funcionario.saime_find(params[:prefijo],params[:cedula], fix_fecha_nacimiento)
    else
      @funcionario = "Ya hay un funcionario con esta cédula registrado en el sistema"
    end
    render partial: "info_funcionario"
  end

  def create
    current_funcionario.update_datos(funcionario_params[:cedula], funcionario_params[:telefono_casa], funcionario_params[:telefono_celular], funcionario_params[:direccion])
    respond_to do |format|
      if current_funcionario.errors.any?
        format.html{ render '_first_funcionario'}
        format.json { render json: current_funcionario.errors, status: :unprocessable_entity }
      else
        format.html{ redirect_to root_path, notice: "Ha terminado su registro como funcionario" and return}
      end
    end
  end

  def update
  end

  private
    def funcionario_params
      params.require(:funcionario).permit(:cedula, :telefono_casa, :telefono_celular, :direccion)
    end

    def fix_fecha_nacimiento
      Date.new(params[:ano].to_i,params[:mes].to_i,params[:dia].to_i)
    end

end