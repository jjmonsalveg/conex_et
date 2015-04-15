# == Schema Information
#
# Table name: marcas
#
#  id           :integer          not null, primary key
#  ID_MARCA     :string
#  NOMBRE_MARCA :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Marca < ActiveRecord::Base
  self.establish_connection :inttt_database

  def self.marca(id_marca)
    marca = self.find_by(ID_MARCA: id_marca)
    return marca.nil? ? 'NULL': marca.NOMBRE_MARCA
  end

end
