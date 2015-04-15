class CreateVistas < ActiveRecord::Migration
  def change
    create_table :vistas do |t|
      t.string  :descripcion, limit: 100, default: ""
      t.string  :nombre, limit: 35, null: false
      t.integer :index
      t.boolean :any_grupo_documentos_uno, default:false
      t.references :tipo_solicitud, index: true
      t.timestamps
    end
    add_index :vistas, [:id,:tipo_solicitud_id],unique: true
    add_index :vistas, :nombre,unique: true
  end
end
