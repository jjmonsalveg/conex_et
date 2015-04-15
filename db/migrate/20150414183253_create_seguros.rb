class CreateSeguros < ActiveRecord::Migration
  def change
    create_table :seguros do |t|
      t.integer :num_poliza
      t.date :fecha_vencimiento
      t.references :aseguradora, index: true
      t.references :vehiculo_pre, index: true

      t.timestamps
    end
  end
end
