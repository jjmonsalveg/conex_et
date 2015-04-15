# == Schema Information
#
# Table name: seguros
#
#  id                :integer          not null, primary key
#  num_poliza        :integer
#  fecha_vencimiento :date
#  aseguradora_id    :integer
#  vehiculo_pre_id   :integer
#  created_at        :datetime
#  updated_at        :datetime
#  solicitud_id      :integer
#
# Indexes
#
#  index_seguros_on_aseguradora_id   (aseguradora_id)
#  index_seguros_on_vehiculo_pre_id  (vehiculo_pre_id)
#

class Seguro < ActiveRecord::Base
  belongs_to :aseguradora
  belongs_to :vehiculo_pre
  belongs_to :solicitud

  #DOCUMENTOS - NESTED ES OBLIGATORIO
  has_many :documentos,  dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true
end
