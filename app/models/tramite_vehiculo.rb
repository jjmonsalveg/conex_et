# == Schema Information
#
# Table name: tramite_vehiculos
#
#  id                         :integer          not null, primary key
#  NRO_TRAMITE                :string
#  PLACA                      :string
#  SERIAL_CARROCERIA          :string
#  ID_COLOR1                  :string
#  ID_COLOR2                  :string
#  ID_USO                     :string
#  ID_TIPO_VEHICULO           :string
#  ID_CATEGORIA               :string
#  ID_CLASE                   :string
#  ID_MARCA                   :string
#  SERIAL_MOTOR               :string
#  SERIAL_CHASSIS             :string
#  PLACA_ANTERIOR             :string
#  NRO_EJES                   :integer
#  NRO_PUESTOS                :integer
#  NRO_IDENTIFICACION_RESERVA :string
#  MODELO                     :string
#  ANO                        :integer
#  CAPACIDAD                  :integer
#  NRO_PROPIETARIO            :string
#  marca_id                   :integer
#  uso_id                     :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_tramite_vehiculos_on_marca_id  (marca_id)
#  index_tramite_vehiculos_on_uso_id    (uso_id)
#

class TramiteVehiculo < ActiveRecord::Base
  belongs_to :marca
  self.establish_connection :inttt_database
  def self.find_by_placa_carroceria_ano(placa, s_carroceria, ano)
    vehiculo = self.where(PLACA: placa.upcase, SERIAL_CARROCERIA: s_carroceria.upcase, ANO: ano).last
    # self.connection.disconnect!
    return vehiculo
  end



end
