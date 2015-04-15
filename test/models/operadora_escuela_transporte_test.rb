# == Schema Information
#
# Table name: operadora_escuela_transportes
#
#  id           :integer          not null, primary key
#  razonSocial  :string(25)       default(""), not null
#  rif          :string(10)       default(""), not null
#  email        :string(50)       default(""), not null
#  telefono     :string(10)       default(""), not null
#  movil        :string(10)       default("")
#  avenida      :string(15)
#  calle        :string(10)
#  urbanizacion :string(15)
#  edificio_cc  :string(15)
#  local        :string(15)
#  piso         :string(15)
#  codigoET     :string(10)
#  url          :string(150)
#  estado       :integer          default(0), not null
#  created_at   :datetime
#  updated_at   :datetime
#  usuario_id   :integer          not null
#

require 'test_helper'

class OperadoraEscuelaTransporteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
