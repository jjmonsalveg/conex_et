class AddNombreComercialToEscuelaTransportes < ActiveRecord::Migration
  def up
    add_column :escuela_transportes, :nombre_comercial, :string
  end

  def down
    remove_column :escuela_transportes, :nombre_comercial, :string
  end
end
