# -*- encoding : utf-8 -*-
class Tciudadano < ActiveRecord::Base
  def self.find_cedula(cedula)
    self.establish_connection "saime_#{Rails.env}".to_sym
    self.pluralize_table_names = false
    persona = self.find_by(ccedula: cedula)
    self.connection.disconnect!
    return persona
  end
end

