# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: session_users
#
#  id                     :integer          not null, primary key
#  email                  :string(50)       default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  unique_session_id      :string(20)
#  created_at             :datetime
#  updated_at             :datetime
#  usuario_sput_id        :integer          not null
#
# Indexes
#
#  index_session_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_session_users_on_email                 (email) UNIQUE
#  index_session_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_session_users_on_usuario_sput_id       (usuario_sput_id) UNIQUE
#

class SessionUser < ActiveRecord::Base
  include RegexHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable, :session_limitable
  devise :database_authenticatable,:authentication_keys => [:email]

  #asociaciones
  has_one :representante_legal
  belongs_to :usuario_sput
  accepts_nested_attributes_for :usuario_sput
  include ShowAtributosHelper

  #validates
  # validates_presence_of :email_confirmation , on: :create
  # validates :email,:length => {  maximum: 50,
  #                                message:
  #                                 'Email debe contener máximo 50 caracteres'
  #           }
  # validates_format_of :email, with: VALID_EMAIL_REGEX
  # validates_confirmation_of :email,
  #                           message: 'Correo y su confirmación no coincide'
  # validates :usuario_sput_id,
  #           uniqueness: {message: 'Error del sistema, no duplicados de registro'}
  # validate :correos_diferentes

  def correos_diferentes
    if self.usuario_sput.correo_alterno == self.email
      errors.add(:email, 'Debe usar un correo alterno diferente al email principal')
    end
  end

  def authentication_key
    return self.email
  end

  def escuela_transportes
    self.representante_legal.escuela_transportes
  end

  def razon_social
    self.representante_legal.razonSocial
  end

  def cedula_sput
    self.usuario_sput.numero_doc
  end

  def nombres
    self.usuario_sput.nombre
  end

  def apellidos
    self.usuario_sput.apellido
  end

  def escuelas_nuevas
     escuelas {|escuela|  DocumentosRequisitosPorVista.vista_completa?(:registro_inicial,escuela) and escuela.tipo_escuela_id.nil?}
  end

  def escuelas_preinscritas
     escuelas {|escuela|  DocumentosRequisitosPorVista.vista_completa?(:registro_inicial,escuela) and escuela.tipo_escuela_id.present?}
  end

  def escuelas_registradas
    escuelas {|escuela|  DocumentosRequisitosPorVista.vista_completa?(:registro_inicial,escuela)}
  end

  ##### METODOS DE REPRESENTANTE LEGAL ##
  def rif
    rif = self.representante_legal.rif[0]
    rif +='-'
    rif += self.representante_legal.rif[1..self.representante_legal.rif.length-2]
    rif +='-'
    rif += self.representante_legal.rif[self.representante_legal.rif.length-1]
    return rif
  end
  
  ######### METODOS DE USUARIO SPUT
  def apellido
    self.usuario_sput.apellido
  end

  def nombre
    self.usuario_sput.nombre
  end

  def telefono
    self.usuario_sput.telefono_local
  end

  def movil
    self.usuario_sput.movil
  end

  def numero_doc
    self.usuario_sput.nacionalidad+ '-'+ self.usuario_sput.numero_doc
  end

  private

  def escuelas
    self.escuela_transportes.to_a.select{|escuela| yield(escuela)}
  end

end

