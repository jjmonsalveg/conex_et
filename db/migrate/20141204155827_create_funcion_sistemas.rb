class CreateFuncionSistemas < ActiveRecord::Migration
  def change
    create_table :funcion_sistemas do |t|
      t.string :nombre, null: false, limit: 50, default:""
      t.string :accion, null: false, limit: 50, default:""
      t.string :clase_controlador, limit: 60, default: ""
      t.references :eventos_work_flow
      t.timestamps
    end

    create_table :funcion_sistemas_rols, :id => false do |t|
      t.references :rol, index:true
      t.references :funcion_sistema, index:true
    end
    add_index :funcion_sistemas, :eventos_work_flow_id
    add_index :funcion_sistemas_rols, [:funcion_sistema_id, :rol_id], unique: true
  end
end
