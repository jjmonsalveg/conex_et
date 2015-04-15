# == Schema Information
#
# Table name: funcion_sistemas
#
#  id                   :integer          not null, primary key
#  nombre               :string(50)       default(""), not null
#  accion               :string(50)       default(""), not null
#  clase_controlador    :string(60)       default("")
#  eventos_work_flow_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#
# Indexes
#
#  index_funcion_sistemas_on_eventos_work_flow_id  (eventos_work_flow_id)
#

require 'test_helper'

class FuncionSistemaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
