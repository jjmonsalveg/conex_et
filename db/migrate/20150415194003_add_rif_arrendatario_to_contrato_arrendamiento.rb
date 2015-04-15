class AddRifArrendatarioToContratoArrendamiento < ActiveRecord::Migration
  def change
    add_column :contrato_arrendamientos, :rif_arrendatario, :string
  end
end
