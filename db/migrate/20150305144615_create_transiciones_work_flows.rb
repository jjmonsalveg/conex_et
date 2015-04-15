class CreateTransicionesWorkFlows < ActiveRecord::Migration
  def change
    create_table :transiciones_work_flows do |t|
      t.integer :estado_fuente_id   , null:false
      t.integer :estado_destino_id  ,null:false
      t.references :EventosWorkFlow , index: true, null:false

      t.timestamps
    end

    add_index :transiciones_work_flows,:estado_fuente_id
    add_index :transiciones_work_flows,:estado_destino_id
    add_index :transiciones_work_flows,
              [:estado_fuente_id,:estado_destino_id,:EventosWorkFlow_id],
              unique: true, name: 'index_matriz'
  end
end
