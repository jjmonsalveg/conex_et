# == Schema Information
#
# Table name: transiciones_work_flows
#
#  id                 :integer          not null, primary key
#  estado_fuente_id   :integer          not null
#  estado_destino_id  :integer          not null
#  EventosWorkFlow_id :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_matriz                                         (estado_fuente_id,estado_destino_id,EventosWorkFlow_id) UNIQUE
#  index_transiciones_work_flows_on_EventosWorkFlow_id  (EventosWorkFlow_id)
#  index_transiciones_work_flows_on_estado_destino_id   (estado_destino_id)
#  index_transiciones_work_flows_on_estado_fuente_id    (estado_fuente_id)
#

class TransicionesWorkFlow < ActiveRecord::Base
  #config/includes

  #associations
  belongs_to :EventosWorkFlow
  belongs_to :estado_destino , class_name: "EstadosWorkFlow"
  belongs_to :estado_fuente  , class_name: "EstadosWorkFlow"

  #callback declaration
  #   EMPTY
  
  #validates field
  validates :EventosWorkFlow_id, presence: true
  validates :estado_fuente_id, presence: true
  validates :estado_destino_id, presence: true
  validates_uniqueness_of :EventosWorkFlow_id, scope: [:estado_fuente_id,:estado_destino_id],
                          message: 'tomado por un contacto de este cliente'

  #callbacks definition
  #   EMPTY

  #helps methods
  #   EMPTY


end
