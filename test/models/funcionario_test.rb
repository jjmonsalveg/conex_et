# == Schema Information
#
# Table name: funcionarios
#
#  id                     :integer          not null, primary key
#  login                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  email                  :string(255)      default("")
#  nombre                 :string(60)       default("")
#  apellido               :string(50)       default("")
#  nacionalidad           :string(1)        default("")
#  cedula                 :integer          default(0)
#  direccion              :text             default("")
#  sexo                   :string(1)        default("")
#  telefono_casa          :string(30)       default("")
#  telefono_celular       :string(30)       default("")
#  estado                 :integer          default(0)
#  unique_session_id      :string(20)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_funcionarios_on_login                 (login) UNIQUE
#  index_funcionarios_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'test_helper'

class FuncionarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
