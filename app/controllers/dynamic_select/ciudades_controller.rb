# -*- encoding : utf-8 -*-
module DynamicSelect
  class CiudadesController < ApplicationController
    respond_to :json
    def index
      #estado = ActionController::Parameters.new(estado_id: params[:estado_id]).permit(:estado_id)[:estado_id]
      @ciudades = Ciudad.where(estado_id: params[:estado_id]).select('id','nombre')
      respond_with(@ciudades)
    end

    def ciudad_municipio
      estado = ActionController::Parameters.new(estado: params[:estado_id]).permit(:estado)[:estado]
      municipio_a = []
      ciudad_b = []
      json_ = []
      municipio_a << {
          id: "",
          label: "Seleccione un Municipio",
      }
      ciudad_b << {
          id: "",
          label: "Seleccione una Ciudad",
      }
      m = Municipio.where(estado_id: estado)
      c = Ciudad.where(estado_id: estado)
      m.each do |i|
        municipio_a <<{
            id: i.id,
            label: i.nombre,
        }
      end
      c.each do |i|
        ciudad_b <<{
            id: i.id,
            label: i.nombre,
        }
      end
      json_ << municipio_a << ciudad_b
      render json: json_
    end
  end
end