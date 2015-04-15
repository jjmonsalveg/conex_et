# == Schema Information
#
# Table name: representante_legal
#
#  id                        :integer          not null, primary key
#  estado_representante      :integer          default(0), not null
#  rif                       :string(10)       not null
#  session_user_id           :integer
#  usuario_sput_id           :integer          not null
#  doc_rif                   :string(255)      not null
#  doc_gaceta_naturalizacion :string(255)
#  doc_cedula                :string(255)      not null
#  direccion                 :string(255)      not null
#
# Indexes
#
#  index_representante_legal_on_doc_cedula                 (doc_cedula)
#  index_representante_legal_on_doc_gaceta_naturalizacion  (doc_gaceta_naturalizacion)
#  index_representante_legal_on_doc_rif                    (doc_rif)
#  index_representante_legal_on_session_user_id            (session_user_id) UNIQUE
#  index_representante_legal_on_usuario_sput_id            (usuario_sput_id) UNIQUE
#

class RepresentanteLegal < ActiveRecord::Base

  #configuracion/includes
  include RegexHelper
  include ShowAtributosHelper
  self.pluralize_table_names = false

  mount_uploader :doc_rif , ImgDocUploader
  mount_uploader :doc_gaceta_naturalizacion, ImgDocUploader
  mount_uploader :doc_cedula, ImgDocUploader

  enum estado_representante: [:temporal,:en_proceso,:autorizado]


  #asociaciones
  belongs_to :usuario_sput
  belongs_to :session_user
  has_many   :escuela_transportes

  #callback declaration

  #validates field
  validates :session_user_id, :uniqueness => true
  validates :usuario_sput_id, :uniqueness => true
  validates :rif, presence: { message: 'El campo Rif es obligatorio'},
            format: {with:RIF_REGEX_SIGN_UP,
                     message: 'El formato del campo Rif es inválido' },
            :length => {  maximum: 10,
                          message:
                              'Rif debe contener máximo 10 caracteres'
            }
  validates :usuario_sput_id,uniqueness: {message: 'Error del sistema no duplicados de registro'}
  validates :rif, presence: { message: 'El campo Rif es obligatorio'},
            format: {with:RIF_REGEX_SIGN_UP,
                     message: 'El formato del campo Rif es inválido' },
            :length => {  maximum: 10,
                          message:
                              'Rif debe contener máximo 10 caracteres'
            }
  validates :doc_rif, document_size: true,
            presence:{message:'El campo  Rif Digitalizado es obligatorio'}
  validates :doc_cedula, document_size: true,
            presence:{message:'El campo Cédula de Identidad Digitalizada es obligatorio'}
  validates :doc_gaceta_naturalizacion, document_size: true

  validates :direccion, presence: { message: 'El campo Dirección es obligatorio'},
            :length => {  maximum: 255,
                          message:
                              'Rif debe contener máximo 255 caracteres'
            }

  #callbacks definition

  #helps methods

  def document_path
    "#{self.class}/#{self.id}/REGISTRO"
  end
end

