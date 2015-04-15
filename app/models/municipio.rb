# == Schema Information
#
# Table name: municipios
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  estado_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_municipios_on_estado_id  (estado_id)
#

class Municipio < ActiveRecord::Base
  belongs_to :estado
  has_many :parroquias
  has_many :interesado_cets
end
