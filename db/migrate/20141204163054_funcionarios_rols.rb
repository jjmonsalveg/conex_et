class FuncionariosRols < ActiveRecord::Migration
  def change
    create_table :funcionarios_rols, id: false do |t|
      t.references :funcionario, :rol
    end
    add_index :funcionarios_rols, [:funcionario_id, :rol_id]
  end
end
