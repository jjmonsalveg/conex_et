# == Schema Information
#
# Table name: tipo_escuelas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TipoEscuela < ActiveRecord::Base
  has_many :interesado_cets
  has_many :escuela_transportes

  validates :nombre, presence: true
end
