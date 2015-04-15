class CreateContratoArrendamientos < ActiveRecord::Migration
  def change
    create_table :contrato_arrendamientos do |t|
      t.string :nombre_arrendatario
      t.string :rif
      t.date :fecha
      t.integer :duracion
      t.integer :tomo
      t.integer :folio
      t.string :notaria
      t.string :nombre_arrendador

      t.references :vehiculo_pre, index: true

      t.timestamps
    end
  end
end
