# -*- encoding : utf-8 -*-
module DynamicSelect
  class ParroquiasController < ApplicationController
    respond_to :json

    def index
      @parroquias = Parroquia.where(municipio_id: params[:municipio_id]).select('id','nombre')
      respond_with(@parroquias)
    end

  end
end