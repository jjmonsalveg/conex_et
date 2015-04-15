# == Schema Information
#
# Table name: funcion_sistemas
#
#  id                   :integer          not null, primary key
#  nombre               :string(50)       default(""), not null
#  accion               :string(50)       default(""), not null
#  clase_controlador    :string(60)       default("")
#  eventos_work_flow_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#
# Indexes
#
#  index_funcion_sistemas_on_eventos_work_flow_id  (eventos_work_flow_id)
#

class FuncionSistema < ActiveRecord::Base
  has_and_belongs_to_many :rols
  belongs_to :eventos_work_flow
  has_many :buttons , dependent: :destroy
  def nombre_accion_controlador
    "Nombre: "+ self.nombre + " - Accion: " + self.accion + " -  Controlador: " + (self.clase_controlador || "")
  end

  def self.get_funcion_sistema(nombre)
    find_by(nombre: nombre).last
  end
end
