# -*- encoding : utf-8 -*-
module DynamicSelect
  class MunicipiosController < ApplicationController
    respond_to :json

    def index
      estado = ActionController::Parameters.new(estado: params[:estado_id]).permit(:estado)[:estado]
      @municipios = Municipio.where(estado_id: estado).select('id','nombre')
      respond_with(@municipios)
    end
  end
end