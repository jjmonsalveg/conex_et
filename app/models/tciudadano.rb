# -*- encoding : utf-8 -*-
class Tciudadano < ActiveRecord::Base
  self.establish_connection "saime_#{Rails.env}".to_sym
  self.pluralize_table_names = false

  def self.find_cedula(cedula)
    self.find_by(ccedula: cedula)
  end

end

