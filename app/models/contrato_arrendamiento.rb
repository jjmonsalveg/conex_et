# == Schema Information
#
# Table name: contrato_arrendamientos
#
#  id                  :integer          not null, primary key
#  nombre_arrendatario :string(255)
#  rif                 :string(255)
#  fecha               :date
#  duracion            :integer
#  tomo                :integer
#  folio               :integer
#  notaria             :string(255)
#  nombre_arrendador   :string(255)
#  vehiculo_pre_id     :integer
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_contrato_arrendamientos_on_vehiculo_pre_id  (vehiculo_pre_id)
#

class ContratoArrendamiento < ActiveRecord::Base
  belongs_to :vehiculo_pre

  #DOCUMENTOS - NESTED ES OBLIGATORIO
  has_many :documentos,  dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true

end
