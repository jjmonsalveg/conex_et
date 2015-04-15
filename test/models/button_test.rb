# == Schema Information
#
# Table name: buttons
#
#  id                 :integer          not null, primary key
#  helper_path        :string(255)      not null
#  style              :string(255)      not null
#  icon               :string(255)      not null
#  text               :string(255)      not null
#  funcion_sistema_id :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_buttons_on_funcion_sistema_id  (funcion_sistema_id)
#

require 'test_helper'

class ButtonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
