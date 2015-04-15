# == Schema Information
#
# Table name: interesado_cets
#
#  id              :integer          not null, primary key
#  nombre          :string(60)       default(""), not null
#  apellido        :string(60)       default(""), not null
#  nacionalidad    :string(1)        default(""), not null
#  cedula          :integer          not null
#  telefono        :string(10)       not null
#  email           :string(25)       not null
#  nro_consultas   :integer          default(1)
#  municipio_id    :integer          not null
#  ciudad_id       :integer          not null
#  tipo_escuela_id :integer          not null
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_interesado_cets_on_cedula           (cedula) UNIQUE
#  index_interesado_cets_on_ciudad_id        (ciudad_id)
#  index_interesado_cets_on_municipio_id     (municipio_id)
#  index_interesado_cets_on_tipo_escuela_id  (tipo_escuela_id)
#

class InteresadoCet < ActiveRecord::Base

  include RegexHelper

  belongs_to :ciudad
  belongs_to :municipio
  belongs_to :tipo_escuela

  before_validation :clean_telefono

  validates :nombre, presence: true, length: {maximum: 60}

  validates :apellido, presence: true, length: {maximum: 60}

  validates :nacionalidad, presence: true, length: {maximum: 1}

  validates :cedula, numericality: true, length: {maximum: 9}

  validates :email,
            presence: { message: 'Correo electrónico es requerido'},
            format: {
                with:     VALID_EMAIL_REGEX,
                message: 'Correo electrónico no cumple con formato'
            },
            :length => {  maximum: 50,
                          message:
                              'Correo electrónico debe contener máximo 25 caracteres'
            }

  validates :ciudad_id, presence: {message: 'Ciudad no puede estar en blanco'}
  validates :municipio_id, presence: true
  validates :tipo_escuela_id,presence: true
  validates :telefono, presence: true

  #validates_format_of :email, with: VALID_EMAIL_REGEX

  def self.find_in_saime(cedula)
    persona = Tciudadano.find_cedula(cedula)
    if persona
      @interesado_cet = InteresadoCet.new(nombre: persona.dnombre_1 + " "+ (persona.dnombre_2 || ""), apellido: persona.dapellido_1 + " "+ (persona.dapellido_2 || ""), nacionalidad: persona.dnacionalidad, cedula: persona.ccedula)
    end
  end

  def self.new_registro(parametros)
    @interesado_cet = find_in_saime(parametros[:cedula])
    if @interesado_cet
      @interesado_cet.email = parametros[:email]
      @interesado_cet.telefono = parametros[:telefono]
      @interesado_cet.ciudad_id = parametros[:ciudad_id]
      @interesado_cet.municipio_id = parametros[:municipio_id]
      @interesado_cet.tipo_escuela_id = parametros[:tipo_escuela_id]
      @interesado_cet.save!
      return @interesado_cet
    end
  end

  def clean_telefono
    self.telefono = self.telefono.gsub("(","").gsub(")","").gsub(" ","").gsub("-","")
  end



end
