class CreateCircuitos < ActiveRecord::Migration
  def change
    create_table :circuitos do |t|
      t.integer :tipo_circuito  , null:false
      t.string :descripcion_ruta, null: false
      t.references :solicitud   , null:false
      t.boolean :status , default: true

      t.timestamps
    end
  end
end
