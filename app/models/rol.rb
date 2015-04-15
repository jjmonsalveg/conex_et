# == Schema Information
#
# Table name: rols
#
#  id         :integer          not null, primary key
#  nombre     :string(50)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#

class Rol < ActiveRecord::Base
  has_and_belongs_to_many :funcionarios
  has_and_belongs_to_many :funcion_sistemas

  validates :nombre, presence: true
end
