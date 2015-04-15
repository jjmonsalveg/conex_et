class AddPlanillaTimeToSolicituds < ActiveRecord::Migration
  def change
    add_column :solicituds, :planilla_time, :timestamp
  end
end
