class CreateInteresadoCets < ActiveRecord::Migration
  def change
    create_table :interesado_cets do |t|
      t.string :nombre, limit: 60, default:"", null: false
      t.string :apellido, limit: 60, default:"", null: false
      t.string :nacionalidad, limit: 1, default:"", null: false
      t.integer :cedula, null: false
      t.string :telefono, limit: 10, null: false
      t.string :email, limit: 25, null: false
      t.integer :nro_consultas, default: 1
      t.references :municipio, index: true, null: false
      t.references :ciudad, index: true, null: false
      t.references :tipo_escuela, index: true, null: false

      t.timestamps
    end
    add_index :interesado_cets, :cedula, unique: true
  end
end
