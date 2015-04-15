# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: usuario_sputs
#
#  id               :integer          not null, primary key
#  nombre           :string(60)       not null
#  apellido         :string(50)       not null
#  nacionalidad     :string(1)        not null
#  numero_doc       :string(8)        not null
#  telefono_local   :string(10)
#  movil            :string(10)       not null
#  correo_alterno   :string(50)
#  pregunta_secreta :string(30)       not null
#  respuesta        :string(15)       not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_usuario_sputs_on_numero_doc  (numero_doc) UNIQUE
#

class UsuarioSput < ActiveRecord::Base

  #configuracion/includes
  self.establish_connection "sput_#{Rails.env}".to_sym
  include RegexHelper
  include ShowAtributosHelper

  #asociaciones
  has_one :session_user
  has_one :representante_legal
  accepts_nested_attributes_for :representante_legal

  #callbacks
  before_validation do
    self.telefono_local =
        telefono_local.gsub(/[\(\) -]/, "") if attribute_present? ('telefono_local')
  end

  before_save do
    self.pregunta_secreta.upcase!
    self.respuesta.upcase!
    self.nombre.upcase!
    self.apellido.upcase!
  end

  #validates
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

  validates :numero_doc , presence: {message: 'El campo Número Cédula es obligatorio'},
            format: {with: CEDULA_REGEX,
                     message: 'El formato del campo Número Cédula es inválido'},
            :length => {  maximum: 8,
                          message:
                              'Apellido debe contener máximo 50 caracteres'
            }
  validates :telefono_local ,
            format: {with: TELEFONO_LOCAL_REGEX,
                     message: 'El formato del campo Teléfono local es inválido',
                     :allow_blank => true
            }
  validates :movil,
            format: {with: MOVIL_REGEX,
                     message: 'El formato del campo Teléfono Móvil es inválido'},
            presence: {message: 'El campo Teléfono Móvil es obligatorio'},
            :length => {  is: 10,
                          message:
                              'Debe introducir 7 dígitos en Teléfono Móvil  '
            }
  validates :correo_alterno,
            format: {with: VALID_EMAIL_REGEX,
                     message: 'El formato del campo Correo Alterno es inválido'}, :allow_blank => true,
            :length => {  maximum: 50,
                          message:
                              'Correo Alterno debe contener máximo 30 caracteres'
            }
  validates :pregunta_secreta,
            format: {with: ALFANUMERICO_REGEX,
                     message: 'El formato  del campo Pregunta secreta inválido. (formato alfanumérico)'},
            presence: {message: 'El campo Pregunta secreta es obligatorio'},
            :length => {  maximum: 30,
                          message:
                              'Pregunta secreta debe contener máximo 28 carácteres'
            }
  validates :respuesta,
            format: {with: ALFANUMERICO_REGEX,
                     message: 'El formato del campo Respuesta secreta es inválido. (formato alfanumérico)'},
            presence: {message: 'El campo Respuesta secreta es obligatorio'},
            :length => {  maximum: 15,
                          message:
                              'Respuesta secreta debe contener máximo 15 carácteres'
            }
end
