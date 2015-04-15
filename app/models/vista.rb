# == Schema Information
#
# Table name: vistas
#
#  id                       :integer          not null, primary key
#  descripcion              :string(100)      default("")
#  nombre                   :string(35)       not null
#  index                    :integer
#  any_grupo_documentos_uno :boolean          default(FALSE)
#  tipo_solicitud_id        :integer
#  created_at               :datetime
#  updated_at               :datetime
#
# Indexes
#
#  index_vistas_on_id_and_tipo_solicitud_id  (id,tipo_solicitud_id) UNIQUE
#  index_vistas_on_nombre                    (nombre) UNIQUE
#  index_vistas_on_tipo_solicitud_id         (tipo_solicitud_id)
#

class Vista < ActiveRecord::Base
  self.table_name = :vistas

  belongs_to :tipo_solicitud
  has_many :documentos_requisitos_por_vistas
  has_many :documento_requisitos, through: :documentos_requisitos_por_vistas

  def self.find_documentos_requisitos(nombre_vista)
    (self.includes(:documento_requisitos).find_by(nombre: nombre_vista,documento_requisitos: {paginado:true})).documento_requisitos
  end
  def grupos?
    return self.any_grupo_documentos_uno
  end
end
