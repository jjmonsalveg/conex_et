# == Schema Information
#
# Table name: traza_solicitud_funcionarios
#
#  id             :integer          not null, primary key
#  solicitud_id   :integer          not null
#  funcionario_id :integer          not null
#  observacion    :string(255)
#  estado_inicial :integer          not null
#  estado_final   :integer          not null
#  ip_funcionario :inet
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_traza_solicitud_funcionarios_on_funcionario_id  (funcionario_id)
#  index_traza_solicitud_funcionarios_on_solicitud_id    (solicitud_id)
#

class TrazaSolicitudFuncionario < ActiveRecord::Base
  #associations
  belongs_to :funcionario
  belongs_to :solicitud

  # enum estado_incial: [:creada , :preparada, :completa,:aprobada,:rechazada]
  # enum estado_final:  [:creada , :preparada, :completa,:aprobada,:rechazada]
  #           status:     0           1           2         3          4
  #creada    : La solicitud ha sido creada en la base de datos (lógica para programador)
  #preparada : La solicitud ya tiene la mascara en 1111 es decir cargo todos los documentos
  #completa  : El representante legal hace click en boton para que la solicitud sea verificada
  #aprobada  : La solicitud ha sido aprobada
  #rechazada : "                  " rechazada

  #callback declaration
  validates_presence_of :solicitud_id
  validates_presence_of :funcionario_id
  validates_presence_of :estado_final,:estado_inicial
end
