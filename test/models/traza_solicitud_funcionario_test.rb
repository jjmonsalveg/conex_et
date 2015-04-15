# == Schema Information
#
# Table name: traza_solicitud_funcionarios
#
#  id             :integer          not null, primary key
#  solicitud_id   :integer          not null
#  funcionario_id :integer          not null
#  observacion    :string(255)
#  estado_inicial :integer          not null
#  estado_final   :integer          not null
#  ip_funcionario :inet
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_traza_solicitud_funcionarios_on_funcionario_id  (funcionario_id)
#  index_traza_solicitud_funcionarios_on_solicitud_id    (solicitud_id)
#

require 'test_helper'

class TrazaSolicitudFuncionarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
