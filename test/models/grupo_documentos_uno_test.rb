# == Schema Information
#
# Table name: grupo_documentos_unos
#
#  id         :integer          not null, primary key
#  mensaje    :string(100)      default(""), not null
#  icon_color :string(15)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class GrupoDocumentosUnoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
