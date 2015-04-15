# == Schema Information
#
# Table name: estados
#
#  id           :integer          not null, primary key
#  nombre       :string(255)
#  codificacion :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Estado < ActiveRecord::Base

  has_many :ciudads
  has_many :municipios

  scope :order_nombre, lambda { order(:nombre) }
end
