# == Schema Information
#
# Table name: work_flows
#
#  id               :integer          not null, primary key
#  nombre           :string(100)      not null
#  TipoSolicitud_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_work_flows_on_TipoSolicitud_id  (TipoSolicitud_id) UNIQUE
#  index_work_flows_on_nombre            (nombre) UNIQUE
#

class WorkFlow < ActiveRecord::Base
  #config/includes
  #   EMPTY

  #associations
  belongs_to  :tipo_solicitud
  has_many    :estados_work_flows , dependent: :destroy, foreign_key: 'Workflow_id'
  has_many    :eventos_work_flows , dependent: :destroy, foreign_key: 'Workflow_id'

  #callback declaration
  #   EMPTY

  #validates field
  validates :nombre,
            presence: { message: 'Nombre del Workflow es requerido'},
            :length => {
                maximum: 100,
                message:'Nombre del Workflow debe contener máximo 50 caracteres'
            },
            uniqueness: {message: 'Nombre del Workflow ya está en uso'}

  validates_uniqueness_of :TipoSolicitud_id
  validates_presence_of   :TipoSolicitud_id

  #callbacks definition
  #   EMPTY

  #helps methods
  #   EMPTY
end
