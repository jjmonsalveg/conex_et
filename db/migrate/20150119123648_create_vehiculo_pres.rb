class CreateVehiculoPres < ActiveRecord::Migration
  def change
    create_table :vehiculo_pres do |t|
      t.integer :puesto
      t.string :placa
      t.string :s_carroceria
      t.integer :ano
      t.string :marca
      t.string :modelo
      t.string :color
      t.integer :capacidad
      t.string :serial_motor
      t.string :tipo_vehiculo
      t.string :uso

      t.string :propietario
      t.string :identificacion_propietario

      t.references :escuela_transporte, index: true

      t.timestamps
    end
    add_index :vehiculo_pres, :placa, unique: true
    add_index :vehiculo_pres, :s_carroceria, unique: true
  end
end
