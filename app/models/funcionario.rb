# == Schema Information
#
# Table name: funcionarios
#
#  id                     :integer          not null, primary key
#  login                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  email                  :string(255)      default("")
#  nombre                 :string(60)       default("")
#  apellido               :string(50)       default("")
#  nacionalidad           :string(1)        default("")
#  cedula                 :integer          default(0)
#  direccion              :text             default("")
#  sexo                   :string(1)        default("")
#  telefono_casa          :string(30)       default("")
#  telefono_celular       :string(30)       default("")
#  estado                 :integer          default(0)
#  unique_session_id      :string(20)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_funcionarios_on_login                 (login) UNIQUE
#  index_funcionarios_on_reset_password_token  (reset_password_token) UNIQUE
#

class Funcionario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include PgSearch
  include RegexHelper

  has_many :solicituds, through: :traza_solicitud_funcionarios

  has_many :traza_solicitud_funcionarios

  has_and_belongs_to_many :rols

  devise  :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :session_limitable
  devise :database_authenticatable,:authentication_keys => [:login]

  before_validation :clean_telefono

  pg_search_scope :funcionario_search, :against => [:login, :nombre, :apellido, :cedula], :ignoring => :accents

  validates :login, uniqueness: {message: "Login en uso."}
  validates :email, presence: { message: 'Correo electrónico es requerido'}, on: :create
  validates :email,
            format: {
                with:     VALID_EMAIL_REGEX,
                message: 'Correo electrónico no cumple con formato'
            },
            :length => {  maximum: 50,
                          message:
                              'Correo electrónico debe contener máximo 25 caracteres'
            },
            uniqueness: {message: 'Correo electrónico ya en uso'}
  validates :login, presence: { message: 'Login es requerido'}, on: :create

  validates :cedula, numericality: true, length: {maximum: 9}

  validates :nombre, length: {maximum: 60}
  validates :apellido, length: {maximum: 50}
  validates :nacionalidad, length: {maximum: 1}
  validates :sexo, length: {maximum: 1}
  validates :telefono_celular, format: {
                                 with:     MOVIL_REGEX,
                                 message: 'Teléfono Celular no cumple con formato'
                             },
            :length => {  maximum: 10,
                          message:
                              'Teléfono Celular debe contener máximo 10 caracteres'
            }, allow_blank: true

  validates :telefono_casa, format: {
                              with:     TELEFONO_LOCAL_REGEX,
                              message: 'Teléfono no cumple con formato'
                          },
            allow_blank: true,
            :length => {  maximum: 10,
                          message:
                              'Teléfono debe contener máximo 10 caracteres'
            }

  def email_required?
    false
  end

  def direccion_nombre_cedula_blank?
    if self.direccion.blank? || self.nombre.blank? || self.apellido.blank? || self.cedula == 0
      return false
    else
      return true
    end
  end

  def update_datos(cedula, telefono_casa, telefono_celular, direccion)
    if direccion.blank? || cedula.blank? || cedula == "0"
      self.errors.add(:direccion, "no puede estar en blanco")
    else
      persona = Tciudadano.find_cedula(cedula)
      if persona.nil?
        self.errors.add(:cedula, "Cedula Invalida")
      elsif Funcionario.new(nombre: self.nombre, apellido: self.apellido, login: self.login, encrypted_password: self.encrypted_password, email: self.encrypted_password, telefono_celular: self.telefono_celular, telefono_casa: self.telefono_casa, direccion: self.direccion)
        self.update(nombre: persona.dnombre_1 + " "+ (persona.dnombre_2 || ""), apellido: persona.dapellido_1 + " "+ (persona.dapellido_2 || ""), nacionalidad: persona.dnacionalidad, cedula: persona.ccedula, sexo: persona.dsexo, telefono_casa: telefono_casa, telefono_celular: telefono_celular, direccion: direccion)
      end
    end
  end

  def authentication_key
    return self.login
  end

  def self.saime_find(prefijo,cedula, fecha_nacimiento)
    persona = Tciudadano.find_cedula(cedula)
    if persona.nil?
      "No se encontro un ciudadano con esa cédula."
    else
      (persona.dnacionalidad == prefijo && persona.ffecha_nac.to_date == fecha_nacimiento)  ? Funcionario.new(nombre: persona.dnombre_1 + " "+ (persona.dnombre_2 || ""), apellido: persona.dapellido_1 + " "+ (persona.dapellido_2 || ""), nacionalidad: persona.dnacionalidad, cedula: persona.ccedula, sexo: persona.dsexo) : "No se encontro un ciudadano con esa cédula."
    end
  end

  def clean_telefono
    self.telefono_casa = self.telefono_casa.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")
    self.telefono_celular = self.telefono_celular.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")
  end

end
