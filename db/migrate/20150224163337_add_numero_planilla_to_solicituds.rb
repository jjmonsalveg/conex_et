class AddNumeroPlanillaToSolicituds < ActiveRecord::Migration
  def change
    add_column :solicituds, :numero_planilla, :integer
  end
end
