class CreateWorkFlows < ActiveRecord::Migration
  def change
    create_table :work_flows do |t|
      t.string :nombre, limit: 100, null:false
      t.references :TipoSolicitud , null:false
      t.timestamps
    end
    add_index :work_flows,:TipoSolicitud_id,unique: true
    add_index :work_flows,:nombre,unique: true
  end
end
