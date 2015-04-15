class CreateSolicituds < ActiveRecord::Migration
  def change
    create_table :solicituds do |t|
      t.integer :servicio_intt_id
      t.string  :servicio_intt_type
      t.integer :estados_work_flow_id
      t.string  :mask_grupo_requisitos
      t.references :tipo_solicitud, index: true
      t.timestamps
    end
  end
end

