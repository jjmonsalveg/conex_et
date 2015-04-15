# == Schema Information
#
# Table name: eventos_work_flows
#
#  id          :integer          not null, primary key
#  nombre      :string(100)      not null
#  Workflow_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_eventos_work_flows_on_Workflow_id             (Workflow_id)
#  index_eventos_work_flows_on_id_and_Workflow_id      (id,Workflow_id) UNIQUE
#  index_eventos_work_flows_on_nombre                  (nombre)
#  index_eventos_work_flows_on_nombre_and_Workflow_id  (nombre,Workflow_id) UNIQUE
#

class EventosWorkFlow < ActiveRecord::Base
  #config/includes
  #   EMPTY

  #associations
  belongs_to :work_flow
  has_many :transiciones_work_flows, dependent: :destroy
  has_many :funcion_sistemas

  #callback declaration
  #   EMPTY

  #validates field
  validates :nombre,
            presence: { message: 'Nombre del Evento Workflow es requerido'},
            :length => {
                maximum: 100,
                message:'Nombre del Evento Workflow debe contener máximo 100 caracteres'
            }
  validates_presence_of :Workflow_id

  validates_uniqueness_of :id, scope: :Workflow_id,
                          message: 'No debe incluir dos veces el mismo evento en Workflow'
  validates_uniqueness_of :nombre, scope: :Workflow_id,
                          message: 'No debe incluir dos veces el mismo nombre evento en Workflow'

  #callbacks definition
  #   EMPTY

  #helps methods
  #   EMPTY

end
