class ContratoArrendamiento < ActiveRecord::Base
  belongs_to :vehiculo_pre

  #DOCUMENTOS - NESTED ES OBLIGATORIO
  has_many :documentos,  dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true

  mount_uploader :contrato_arrendamiento_file, ContratoArrendamientoFileUploader

end
