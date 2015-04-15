# == Schema Information
#
# Table name: vehiculo_pres
#
#  id                         :integer          not null, primary key
#  puesto                     :integer
#  placa                      :string(255)
#  s_carroceria               :string(255)
#  ano                        :integer
#  marca                      :string(255)
#  modelo                     :string(255)
#  color                      :string(255)
#  capacidad                  :integer
#  serial_motor               :string(255)
#  tipo_vehiculo              :string(255)
#  uso                        :string(255)
#  propietario                :string(255)
#  identificacion_propietario :string(255)
#  escuela_transporte_id      :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#
# Indexes
#
#  index_vehiculo_pres_on_escuela_transporte_id  (escuela_transporte_id)
#  index_vehiculo_pres_on_placa                  (placa) UNIQUE
#  index_vehiculo_pres_on_s_carroceria           (s_carroceria) UNIQUE
#

class VehiculoPre < ActiveRecord::Base
  #config/includes
  include ModeloGeneral::ManageDocument

  has_many :documentos, dependent: :destroy, as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true

  belongs_to :solicitud

  has_one :seguro, dependent: :destroy
  has_one :contrato_arrendamiento, dependent: :destroy

  validates_uniqueness_of :placa, message: 'Vehículo pertenece a otra Escuela de Transporte'

  def contrato_arrendamiento_update_or_create(attributes)
    self.contrato_arrendamiento || self.build_contrato_arrendamiento
    self.contrato_arrendamiento.update(attributes)
  end

  def self.build_vehiculo_intt(vehiculo_intt, solicitud)
    propietario = TramitePropietario.find_by(NRO_TRAMITE: vehiculo_intt.NRO_TRAMITE) || TramitePropietario.new
    uso = Uso.find_by(ID_USO: vehiculo_intt.ID_USO) || Uso.new
    tipo_vehiculo = TipoVehiculo.find_by(ID_TIPO_VEHICULO: vehiculo_intt.ID_TIPO_VEHICULO) || TipoVehiculo.new
    marca = Marca.find_by(ID_MARCA: vehiculo_intt.ID_MARCA) || Marca.new
    vehiculo = VehiculoPre.new(placa: vehiculo_intt.PLACA,
                                    s_carroceria: vehiculo_intt.SERIAL_CARROCERIA,
                                    ano: vehiculo_intt.ANO,
                                    marca: marca.NOMBRE_MARCA,
                                    modelo: vehiculo_intt.MODELO,
                                    color: Color.color(vehiculo_intt.ID_COLOR1),
                                    serial_motor: vehiculo_intt.SERIAL_MOTOR,
                                    capacidad: vehiculo_intt.CAPACIDAD,
                                    propietario: [propietario.PRIMER_NOMBRE,
                                                  propietario.SEGUNDO_NOMBRE, propietario.PRIMER_APELLIDO, propietario.SEGUNDO_APELLIDO, propietario.NOMBRE_EMPRESA].reject(&:nil?).join(' '),
                                    identificacion_propietario: [propietario.ID_TIPO_IDENTIFICACION,
                                                                 propietario.NRO_IDENTIFICACION .to_s, propietario.DIGITO_RIF.to_s].reject(&:nil?).join(' '),
                                    puesto: vehiculo_intt.NRO_PUESTOS,
                                    uso: (uso.NOMBRE_USO || ''),
                                    tipo_vehiculo: (tipo_vehiculo.NOMBRE_TIPO || ''  ),
                                    solicitud_id: solicitud.id)

    return vehiculo
  end

  def build_documentos(documento_params)
    documento_params.each do |params|
      self.documentos.build(params[1])
    end
  end

  def certificado_registro
    documento('documentos_vehiculos','certificado_registro')
  end

  def certificado_homologacion
    documento('documentos_vehiculos','certificado_homologacion')
  end

  def certificado_revision_tecnica
    documento('documentos_vehiculos','certificado_revision_tecnica')
  end

  def rcv
    documento('documentos_vehiculos','rcv')
  end

  def bauche_vehiculo
    documento('documentos_vehiculos','bauche_vehiculo')
  end
end
