# == Schema Information
#
# Table name: interesado_cets
#
#  id              :integer          not null, primary key
#  nombre          :string(60)       default(""), not null
#  apellido        :string(60)       default(""), not null
#  nacionalidad    :string(1)        default(""), not null
#  cedula          :integer          not null
#  telefono        :string(10)       not null
#  email           :string(25)       not null
#  nro_consultas   :integer          default(1)
#  municipio_id    :integer          not null
#  ciudad_id       :integer          not null
#  tipo_escuela_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_interesado_cets_on_cedula           (cedula) UNIQUE
#  index_interesado_cets_on_ciudad_id        (ciudad_id)
#  index_interesado_cets_on_municipio_id     (municipio_id)
#  index_interesado_cets_on_tipo_escuela_id  (tipo_escuela_id)
#

require 'test_helper'

class InteresadoCetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
