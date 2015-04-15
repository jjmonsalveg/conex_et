class AddFechaVencimientoRifToEscuelaTransportes < ActiveRecord::Migration
  def up
    add_column :escuela_transportes, :fecha_vencimiento_rif, :date
  end

  def down
    remove_column :escuela_transportes, :fecha_vencimiento_rif, :date
  end
end
