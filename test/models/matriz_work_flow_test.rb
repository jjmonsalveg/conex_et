# == Schema Information
#
# Table name: matriz_work_flows
#
#  id                      :integer          not null, primary key
#  estado_fuente_id        :integer          not null
#  estado_destino_id       :integer          not null
#  TransicionesWorkFlow_id :integer          not null
#  created_at              :datetime
#  updated_at              :datetime
#
# Indexes
#
#  index_matriz                                        (estado_fuente_id,estado_destino_id,TransicionesWorkFlow_id) UNIQUE
#  index_matriz_work_flows_on_TransicionesWorkFlow_id  (TransicionesWorkFlow_id)
#  index_matriz_work_flows_on_estado_destino_id        (estado_destino_id)
#  index_matriz_work_flows_on_estado_fuente_id         (estado_fuente_id)
#

require 'test_helper'

class MatrizWorkFlowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
