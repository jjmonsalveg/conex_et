# == Schema Information
#
# Table name: ciudads
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  estado_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_ciudads_on_estado_id  (estado_id)
#

class Ciudad < ActiveRecord::Base
  belongs_to :estado
  has_many :interesado_cets
end
