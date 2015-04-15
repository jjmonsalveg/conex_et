# == Schema Information
#
# Table name: escuela_transportes
#
#  id                     :integer          not null, primary key
#  razonSocial            :string(50)       default(""), not null
#  tipo_rif               :string(1)        default(""), not null
#  rif                    :integer          not null
#  digito_rif             :integer          not null
#  email                  :string(50)       default(""), not null
#  telefono               :string(10)       default(""), not null
#  movil                  :string(10)       default("")
#  avenida                :string(50)
#  calle                  :string(30)
#  urbanizacion           :string(50)
#  edificio_cc            :string(20)
#  local                  :string(20)
#  codigoET               :string(10)
#  url                    :string(150)
#  piso                   :string(15)
#  estado                 :integer          default(0), not null
#  ciudad_id              :integer          not null
#  parroquia_id           :integer          not null
#  representante_legal_id :integer          not null
#  tipo_escuela_id        :integer
#  created_at             :datetime
#  updated_at             :datetime
#  nombre_comercial       :string(255)
#  fecha_vencimiento_rif  :date
#
# Indexes
#
#  index_escuela_transportes_on_ciudad_id               (ciudad_id)
#  index_escuela_transportes_on_codigoET                (codigoET) UNIQUE
#  index_escuela_transportes_on_digito_rif              (digito_rif)
#  index_escuela_transportes_on_email                   (email) UNIQUE
#  index_escuela_transportes_on_movil                   (movil) UNIQUE
#  index_escuela_transportes_on_parroquia_id            (parroquia_id)
#  index_escuela_transportes_on_razonSocial             (razonSocial) UNIQUE
#  index_escuela_transportes_on_representante_legal_id  (representante_legal_id)
#  index_escuela_transportes_on_rif                     (rif)
#  index_escuela_transportes_on_rif_and_digito_rif      (rif,digito_rif) UNIQUE
#  index_escuela_transportes_on_telefono                (telefono) UNIQUE
#  index_escuela_transportes_on_tipo_escuela_id         (tipo_escuela_id)
#

#TODO before validate save faltan
class EscuelaTransporte < ActiveRecord::Base

  #config/includes
  include RegexHelper
  include ShowAtributosHelper

  #associations
  belongs_to :representante_legal
  belongs_to :ciudad
  belongs_to :parroquia
  belongs_to :tipo_escuela

  has_many :vehiculo_pres, dependent: :destroy

  #modulos genericos J&J

  #config/includes
  include ModeloGeneral::ManageSolicitud
  include ModeloGeneral::ManageDocument

  #associations
  has_many :solicituds , dependent: :destroy, as: :servicio_intt
  has_many :documentos,  dependent: :destroy, as: :modelo

  accepts_nested_attributes_for :documentos, allow_destroy: true
  accepts_nested_attributes_for :solicituds, allow_destroy: true

  #fin modulos genericos J&J

  #callback declaration
  before_validation :clean_form

  #validates field
  validates :razonSocial,
            presence: { message: 'Razón Social es requerido'},
            :length => {
                maximum: 50,
                message:'Razón Social debe contener máximo 50 caracteres'
            },
            uniqueness: {message: 'Razón Social ya está en uso'}

  validates :tipo_rif ,
            presence: { message: 'Tipo Rif es requerido (E,V,J,G)'},
            format: {
                with:RIF_PREFIX,
                message: 'Tipo Rif no cumple con formato (E,V,J,G)'
            },
            :length => {  maximum: 1,
                          message:  'Tipo Rif (E,V,J,G) debe contener máximo 1 caracteres'
            }

  validates :rif,
            presence: { message: 'Rif es requerido'},
            format: {
                with:RIF_AFIX,
                message: 'Rif no cumple con formato'
            },
            :length => {  maximum: 8,
                          message:  'Rif debe contener máximo 8 caracteres'
            }

  validates :digito_rif,
            presence: { message: 'Último Dígito de Rif es requerido'},
            format: {
                with:RIF_SUFIX,
                message: 'Rif no cumple con formato'
            },
            :length => {  maximum: 1,
                          message:  'Este campo es un Dígito del Rif (0-9)'
            }

  validates_uniqueness_of :digito_rif , scope: :rif,
                          message: 'Rif está siendo usado por otra Escuela de Transporte'

  validates :email,
            presence: { message: 'Correo electrónico es requerido'},
            format: {
                with:     VALID_EMAIL_REGEX,
                message: 'Correo electrónico no cumple con formato'
            },
            :length => {  maximum: 50,
                          message:
                              'Correo electrónico debe contener máximo 25 caracteres'
            },
            uniqueness: {message: 'Correo electrónico usado por otra Razón Social'}

  validates :telefono,
            presence: { message: 'Teléfono es requerido'},
            format: {
                with:     TELEFONO_LOCAL_REGEX,
                message: 'Teléfono no cumple con formato'
            },
            :length => {  maximum: 10,
                          message:
                              'Teléfono debe contener máximo 10 caracteres'
            },
            uniqueness: {message: 'Teléfono usado por otra Razón Social'}

  validates :movil, presence: true,
            format: {
                with:     MOVIL_REGEX,
                message: 'Teléfono Móvil no cumple con formato'
            },
            :length => {  maximum: 10,
                          message:
                              'Teléfono Móvil debe contener máximo 10 caracteres'
            },
            uniqueness: {message: 'Teléfono Móvil usado por otra Razón Social'}

  validates :avenida,
            format: {
                with:     DIRECCION_REGEX,
                message: 'Avenida no cumple con formato Alfanumérico'
            }, allow_blank: true,
            :length => {  maximum: 50,
                          message:
                              'Avenida debe contener máximo 50 caracteres'
            }

  validates :calle,
            :length => {  maximum: 30,
                          message:
                              'Calle debe contener máximo 30 caracteres'
            }
  validates :urbanizacion,
            format: {
                with:     DIRECCION_REGEX,
                message: 'Urbanización no cumple con formato Alfanumérico'
            }, allow_blank: true,
            :length => {  maximum: 50,
                          message:
                              'Urbanización debe contener máximo 50 caracteres'
            }
  validates :edificio_cc,
            format: {
                with:     DIRECCION_REGEX,
                message: 'Edificio/CC no cumple con formato Alfanumérico'
            }, allow_blank: true,
            :length => {  maximum: 20,
                          message:
                              'Edificio/CC debe contener máximo 20 caracteres'
            }

  validates :local,
            format: {
                with:     DIRECCION_REGEX,
                message: 'Local no cumple con formato Alfanumérico'
            },
            allow_blank: true,
            :length => {  maximum: 20,
                          message:
                              'Local debe contener máximo 20 caracteres'
            }

  validates :piso,
            numericality: { only_integer: true ,greater_than_or_equal_to:0,
                            message:'El piso debe ser un numero entero mayor que cero' },
            allow_blank: true


  validates :url,
            format: {
                with:     URL_REGEX,
                message: 'Url no cumple con formato'
            },
            allow_blank: true,
            :length => {  maximum: 150,
                          message:
                              'Dirección Pag. Web debe contener máximo 150 caracteres'
            }

  validates :representante_legal_id,
            presence: { message: 'Error del sistema asociando Escuela a Representante Legal'}

  validate :vacios_direccion

  validate :vacios_ubicacion

  validates :parroquia_id , presence:  {message: 'Parroquia es un campo obligatorio'}

  validates :ciudad_id    , presence:  {message: 'Ciudad es un campo obligatorio'}

  #callbacks definition

  #helps methods
  def direccion

    cad = String.new
    cad += 'Av. '+ self.avenida if self.avenida.present?
    cad += 'Calle '+ self.calle if self.calle.present?
    cad += 'Urb. '+ self.urbanizacion if self.urbanizacion.present?
    cad += 'Edif. '+ self.edificio_cc if self.edificio_cc.present?
    cad += 'Piso '+ self.piso if self.piso.present?
    cad += 'Local '+ self.local if self.local.present?

    return cad
  end
  #
  # def documentos_planillas
  #   return Documento.find_by_sql ['SELECT
  #                                   d.*
  #                                 FROM
  #                                   public.solicituds,
  #                                   public.documentos as d,
  #                                   public.documento_requisitos
  #                                 WHERE
  #                                   solicituds.id = d.solicitud_id AND
  #                                   d.documento_requisito_id = documento_requisitos.id
  #                                   AND solicituds.id = ? AND documento_requisitos.nombre = ?;',
  #                                                solicitud(:preinscripcion).id,
  #                                                :planillas_practicas_manejo
  #                                               ]
  #
  # end
  #
  def solicituds_lockeds
    Solicitud.find_by_sql ['
      SELECT
        solicituds.*
      FROM
        public.solicituds,
        public.escuela_transportes
      WHERE
        escuela_transportes.id = solicituds.servicio_intt_id AND
        escuela_transportes.id = ? AND
        solicituds.servicio_intt_type = ? AND
        solicituds.locked = TRUE	', self.id, 'EscuelaTransporte']
  end

  private

  def vacios_direccion
    if self.calle.blank? and self.avenida.blank? and self.urbanizacion.blank?
      errors.add(:avenida, 'Ingrese al menos una avenida, calle o sector/urbanización ')
    end
  end

  def vacios_ubicacion
    if  self.ciudad_id.nil?  and self.parroquia_id.nil?
      errors.add(:avenida, 'Los campos de la Ubicacion(Estado,Municipio,Ciudad,Parroquia) son obligatorios')
    end
  end

  def clean_form
    self.telefono = self.telefono.gsub(/[\(\)\- ]/,'')
  end

end
