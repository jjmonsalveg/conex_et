# == Schema Information
#
# Table name: circuitos
#
#  id               :integer          not null, primary key
#  tipo_circuito    :integer          not null
#  descripcion_ruta :string(255)      not null
#  solicitud_id     :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_circuitos_on_solicitud_id  (solicitud_id) UNIQUE
#

class Circuito < ActiveRecord::Base

  #config/includes
  include RegexHelper

  enum tipo_circuito: [:abierto,:cerrado]

  #associations
  belongs_to :solicitud

  #modulos genericos J&J

  #config/includes
  include ModeloGeneral::ManageDocument

  #associations
  has_many :documentos,  dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true

  #fin modulos genericos J&J

  #validates field

  validates_uniqueness_of :solicitud_id

  validates :descripcion_ruta,
            presence: { message: 'Descripción de la Ubicación o ruta es requerida'},
            format: {
                with:     DIRECCION_REGEX,
                message: 'Ubicación o ruta  no cumple con formato (caracteres especiales no permitidos)'
            },
            :length => {  maximum: 255,
                          message:
                              'Descripción de la Ubicación o ruta debe contener máximo 255 caracteres'
            }

  validates :tipo_circuito ,
            presence: { message: 'Tipo de circuito es requerido'}

  def documentos_registro_circuito_completos?
    boolean_registro= DocumentosRequisitosPorVista.vista_completa?(:registro_circuitos_manejo,self)
    return ( (self.abierto? and boolean_registro and
        DocumentosRequisitosPorVista.vista_completa?(:registro_circuitos_manejo_abierto,self) ) or
        (self.cerrado? and boolean_registro) )
  end
end
