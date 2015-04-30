class CreatePersonals < ActiveRecord::Migration
  def change
    create_table :personals do |t|
      t.string :nombre, null:false, limit:60
      t.string :apellido, null:false , limit:50
      t.string :nacionalidad, null: false , default: 'V', limit:1
      t.string :cedula, null:false,limit: 10
      t.integer :tipo_personal, null:false
      t.integer :status, default:0, null:false
      t.references :solicitud

      t.timestamps
    end
    add_index :personals, [:cedula, :nacionalidad], unique: true
  end
end
