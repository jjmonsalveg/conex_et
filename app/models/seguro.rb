class Seguro < ActiveRecord::Base
  belongs_to :aseguradora
  belongs_to :vehiculo_pre
  has_one :solicitud

  #DOCUMENTOS - NESTED ES OBLIGATORIO
  has_many :documentos,  dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true
end
