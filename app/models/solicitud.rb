# == Schema Information
#
# Table name: solicituds
#
#  id                    :integer          not null, primary key
#  servicio_intt_id      :integer
#  servicio_intt_type    :string(255)
#  estados_work_flow_id  :integer
#  mask_grupo_requisitos :string(255)
#  tipo_solicitud_id     :integer
#  created_at            :datetime
#  updated_at            :datetime
#  planilla_time         :datetime
#  numero_planilla       :integer
#  locked                :boolean          default(FALSE)
#
# Indexes
#
#  index_solicituds_on_tipo_solicitud_id  (tipo_solicitud_id)
#

class Solicitud < ActiveRecord::Base

  #config/includes
  include PgSearch

  #associations

  belongs_to :servicio_intt, polymorphic: true
  belongs_to :tipo_solicitud
  belongs_to :estado, class_name: "EstadosWorkFlow", foreign_key: "estados_work_flow_id"
  has_many :funcionarios , through: :traza_solicitud_funcionarios
  has_many :traza_solicitud_funcionarios


  #modulos genericos J&J

  #config/includes
  include ModeloGeneral::ManageDocument

  #associations
  has_many :documentos,  dependent: :destroy,as: :modelo
  accepts_nested_attributes_for :documentos, allow_destroy: true

  #callback declaration
  validate :almenos_uno
  #fin modulos genericos J&J

  #associations Particularizadas por proyecto
  has_many :personals, dependent: :destroy
  has_many :circuitos, dependent: :destroy
  accepts_nested_attributes_for :circuitos, allow_destroy: true
  has_many :vehiculo_pres, dependent: :destroy
  has_one :seguro

  #callback declaration
  before_create :set_mask_status
  after_initialize :init_workflow

   pg_search_scope :solicitud_search, :against => [:id], :associated_against => {
                                       :servicio_intt => [:rif]
                                   }, :ignoring => :accents

  #callbacks definition
  def set_mask_status
    self.mask_grupo_requisitos = '0' * self.number_vistas_same_index

  end

  #particularizados!
  def seguro_update_or_create(attributes)
    if self.seguro.present?
      self.seguro.update(attributes) ? (return true, self.seguro) : (return false, self.seguro)
    else
      self.build_seguro(attributes)
      self.seguro.save ? (return true, self.seguro) : (return false, self.seguro)
    end
  end

  def seguro_por_vehiculo?
    not VehiculoPre.joins(:seguro).where(seguros: {solicitud_id: self.id}).empty?
  end

  def seguro_por_flota?
    self.seguro.present?
  end

  def seguro_nil_or_por_flota?
   ( not self.seguro_por_flota?) && (not self.seguro_por_vehiculo?) or seguro_por_flota?
  end

  def seguro_nil?
    ( not self.seguro_por_flota?) && (not self.seguro_por_vehiculo?)
  end
  #FIN_particularizados!
  
  #helps methods
  def number_vistas_same_index
    ActiveRecord::Base.connection.execute("SELECT COUNT(DISTINCT vistas.index) as numero_vistas FROM vistas  WHERE vistas.tipo_solicitud_id = #{self.tipo_solicitud.id};")[0]['numero_vistas'].to_i
  end

  def update_index_mask( index = 0, value_boolean = true)
    self.mask_grupo_requisitos[index] = value_boolean ? '1': '0'
    self.update_column(:mask_grupo_requisitos , mask_grupo_requisitos)
    # check_status
  end

  def wizard_complete?
    not self.mask_grupo_requisitos =~ /0/
  end

  def informacion_traza_verificacion_preinscripcion
    ActiveRecord::Base.connection.execute(
        "SELECT
       CONCAT(f.nombre,' ',f.apellido) as funcionario,
       f.cedula as cedula,
       ts.ip_funcionario,
       ts.estado_inicial,
       ts.estado_final  ,
       ts.created_at
    FROM
       public.solicituds as s,
       public.traza_solicitud_funcionarios as ts,
       public.funcionarios as f
    WHERE
       s.id = ts.solicitud_id AND
       f.id = ts.funcionario_id AND s.id= #{self.id} AND ts.estado_final IN (5,4)
    ORDER BY
       created_at;")
  end


  ########################################WORKFLOW###############################

  #                                 ###### Estados Preiscripcion:###
  #creada      : La solicitud ha sido creada en la base de datos (lógica para programador)
  #preparada   : La solicitud ya tiene la mascara en 1111 es decir cargo todos los documentos
  #completa    : El representante legal hace click en boton para que la solicitud sea verificada
  #modificada  : La solicitud ya esta completa pero al modificarla debe generarse de nuevo la planilla
  #para_estudio: La solicitud es revisada y pasada a un estado en espera de estudio
  #diferida    : La solicitud es revisada y por algún motivo diferida
  #aprobada    : La solicitud ha sido aprobada
  #rechazada   : "                  " rechazada
  #en_espera_de_inpeccion: La solicitud es revisada y se le asigna una inspeccion


  #helps methods Workflow
  def current_status
    estado.nombre
  end

  def procesar_evento!(nombre_evento)
    estado_prox = estado.disparar_evento(nombre_evento)

    if estado_prox.nil?
      errors.add(:base,"No existe Transición asociada al evento #{nombre_evento} para el estado de solicitud (#{current_status})")
    else
      self.estados_work_flow_id = estado_prox #estado actual
      save!
    end

  end

  def proximos_estados
    estado.destinos
  end

  def estado?(estado)
    return estado == current_status.to_sym
  end
  ###########FIN_WORKFLOW###############################
  def lock!
    self.locked = true
    save!
  end

  def unlock!
    self.locked = false
    save!
  end
  private

  def init_workflow
    self.estado ||= self.tipo_solicitud.work_flow.estados_work_flows.first rescue nil
  end
end

