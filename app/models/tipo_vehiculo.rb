# == Schema Information
#
# Table name: tipo_vehiculos
#
#  id               :integer          not null, primary key
#  ID_TIPO_VEHICULO :string
#  ID_CATEGORIA     :string
#  ID_CLASE         :string
#  NOMBRE_TIPO      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TipoVehiculo < ActiveRecord::Base
  self.establish_connection :inttt_database

  def self.tipo_vehiculo(id_tipo_vehiculo)
    tipo_vehiculo = self.find_by(ID_TIPO_VEHICULO: id_tipo_vehiculo)
    return tipo_vehiculo.nil? ? 'NULL': tipo_vehiculo.NOMBRE_TIPO
  end


end
