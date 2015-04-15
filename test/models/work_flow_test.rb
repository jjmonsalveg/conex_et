# == Schema Information
#
# Table name: work_flows
#
#  id               :integer          not null, primary key
#  nombre           :string(100)      not null
#  TipoSolicitud_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_work_flows_on_TipoSolicitud_id  (TipoSolicitud_id) UNIQUE
#  index_work_flows_on_nombre            (nombre) UNIQUE
#

require 'test_helper'

class WorkFlowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
