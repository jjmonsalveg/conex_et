# == Schema Information
#
# Table name: tramite_propietarios
#
#  id                        :integer          not null, primary key
#  NRO_TRAMITE               :string
#  NRO_IDENTIFICACION        :integer
#  DIGITO_RIF                :integer
#  ID_TIPO_IDENTIFICACION    :string
#  PRIMER_NOMBRE             :string
#  SEGUNDO_NOMBRE            :string
#  PRIMER_APELLIDO           :string
#  SEGUNDO_APELLIDO          :string
#  FECHA_NACIMIENTO          :date
#  SEXO                      :string
#  NOMBRE_EMPRESA            :string
#  COD_RIF                   :string
#  RIF                       :string
#  NRO_PASAPORTE_DIPLOMATICO :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class TramitePropietario < ActiveRecord::Base
  self.establish_connection :inttt_database
end
