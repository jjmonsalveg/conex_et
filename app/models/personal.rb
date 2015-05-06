# == Schema Information
#
# Table name: personals
#
#  id            :integer          not null, primary key
#  nombre        :string(60)       not null
#  apellido      :string(50)       not null
#  nacionalidad  :string(1)        default("V"), not null
#  cedula        :string(10)       not null
#  tipo_personal :integer          not null
#  status        :integer          default(0), not null
#  solicitud_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_personals_on_cedula_and_nacionalidad  (cedula,nacionalidad) UNIQUE
#

class Personal < ActiveRecord::Base
  #configuracion/includes
  include RegexHelper
  enum status: [:tramitando,:aprobado,:baja]
  enum tipo_personal: [:docente,:instructor,:obrero,:directivo, :administrativo]

  #asociaciones
  belongs_to :solicitud

  #config/includes
  include ModeloGeneral::ManageDocument

  #associations
  has_many :documentos, dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true



  #callback declaration

  #validates field
  validates :nombre , presence: { message: 'El campo Nombre es obligatorio'},
            format: {with: SOLO_CARACTERES_REGEX,
                     message: 'El Formato del campo Nombre es inválido' },
            :length => {  maximum:  60,
                          message:
                              'Nombre debe contener máximo 60 caracteres'
            }
  validates :apellido ,  presence: { message: 'El campo Apellido es obligatorio'},
            format: {with: SOLO_CARACTERES_REGEX,
                     message: 'El Formato del campo Apellido es inválido' },
            :length => {  maximum: 50,
                          message:
                              'Apellido debe contener máximo 50 caracteres'
            }
  validates  :nacionalidad , presence: {message: 'El campo Nacionalidad es obligatorio'},
             format: {with: NACIONALIDAD_REGEX,
                      message: 'El formato del campo Nacionalidad es inválido. (Sólo \'V\' ó \'E\')' }

  validates :cedula , presence: {message: 'El campo Número Cédula es obligatorio'},
            format: {with: CEDULA_REGEX,
                     message: 'El formato del campo Número Cédula es inválido'},
            :length => {  maximum: 8,
                          message:
                              'Apellido debe contener máximo 50 caracteres'
            }

  validates :status, presence: { message: 'El estatus del Trabajador es obligatorio'},
            inclusion: { in: Personal.statuses.keys }
  validates :tipo_personal, presence: { message: 'El tipo de Trabajador es obligatorio'},
           inclusion: { in: Personal.tipo_personals.keys }

  validates_uniqueness_of :cedula, scope: :nacionalidad,
                          message: 'Trabajador ya registrado para una escuela de Transporte'

  def documentos_registro_completos?
    boolean_registro= DocumentosRequisitosPorVista.vista_completa?(:trabajadores,self)
    return ( (self.instructor? and boolean_registro and
        DocumentosRequisitosPorVista.vista_completa?(:trabajadores_instructores,self) ) or
        ((not self.instructor?)  and boolean_registro) )
  end
end
