# == Schema Information
#
# Table name: estados_work_flows
#
#  id          :integer          not null, primary key
#  nombre      :string(100)      default(""), not null
#  Workflow_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_estados_work_flows_on_Workflow_id             (Workflow_id)
#  index_estados_work_flows_on_id_and_Workflow_id      (id,Workflow_id) UNIQUE
#  index_estados_work_flows_on_nombre                  (nombre)
#  index_estados_work_flows_on_nombre_and_Workflow_id  (nombre,Workflow_id) UNIQUE
#

class EstadosWorkFlow < ActiveRecord::Base
  #config/includes
  #   EMPTY

  #associations
  belongs_to :WorkFlow

  has_many :salidas, class_name: "TransicionesWorkFlow",
           foreign_key: :estado_fuente_id,
           dependent: :destroy

  has_many :entradas, class_name: "TransicionesWorkFlow",
           foreign_key: :estado_destino_id,
           dependent: :destroy

  has_many :destinos , through: :salidas   , source: :estado_destino
  has_many :fuentes  , through: :entradas  , source: :estado_fuente
  has_many :eventos  , through: :salidas   , source: :EventosWorkFlow

  has_many :solicituds

  has_and_belongs_to_many :buttons


  #callback declaration
  #   EMPTY

  #validates field

  validates :nombre,
            presence: { message: 'Nombre del Estado Workflow es requerido'},
            :length => {
                maximum: 100,
                message:'Nombre del Estado Workflow debe contener máximo 100 caracteres'
            }
  validates_uniqueness_of :id, scope: :Workflow_id,
                          message: 'No debe incluir dos veces el mismo Estado en Workflow'
  validates_uniqueness_of :nombre, scope: :Workflow_id,
                          message: 'No debe incluir dos veces el mismo nombre Estado en Workflow'

  #callbacks definition
  #   EMPTY

  #helps methods
  def add_destino(estado_destino,evento)
    salidas.create( estado_destino_id: estado_destino.id,
                    EventosWorkFlow_id:evento.id)
  end

  def remove_destino(estado_destino)
    salidas.find_by(estado_destino_id: estado_destino.id).destroy
  end

  def destino?(estado)
    destinos.include?(estado)
  end

  def fuente?(estado)
    destinos.include?(estado)
  end

  def existe_transicion_con_evento?(evento)
    eventos.include?(evento)
  end

  def destino_nombre?(estado)
    destinos.exists?(nombre: estado)
  end

  def fuente_nombre?(estado)
    destinos.exists?(nombre: estado)
  end

  def existe_transicion_con_evento_nombre?(nombre_evento)
    eventos.exists?( nombre: nombre_evento )
  end

  def get_evento(nombre_evento)
    eventos.where(nombre: nombre_evento).last.id
  end

  def get_destino(nombre_evento)
    transicion =salidas.where(EventosWorkFlow_id: get_evento(nombre_evento)).last
    destinos.where(id: transicion.estado_destino_id).last
  end

  def disparar_evento(nombre_evento)
    query = ['
    SELECT
    public.transiciones_work_flows.estado_destino_id as id
    FROM
    public.estados_work_flows,
        public.eventos_work_flows,
        public.transiciones_work_flows
    WHERE
    estados_work_flows.id = transiciones_work_flows.estado_fuente_id AND
    transiciones_work_flows."EventosWorkFlow_id" = eventos_work_flows.id AND estados_work_flows.id = ? AND
    public.eventos_work_flows.nombre =? ',self.id,nombre_evento]

    state = ActiveRecord::Base.connection.execute(ActiveRecord::Base.send(:sanitize_sql_array, query)).first
    state.nil? ? nil : state['id'].to_i
  end

end
