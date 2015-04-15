class ChangePisoTypeInEscuelaTransportes < ActiveRecord::Migration
  def up
    change_column :escuela_transportes, :piso, :string, limit: 15
  end

  def down
    change_column :escuela_transportes, :piso, :integer
  end
end
