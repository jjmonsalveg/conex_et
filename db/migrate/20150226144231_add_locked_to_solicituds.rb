class AddLockedToSolicituds < ActiveRecord::Migration
  def up
    add_column :solicituds, :locked, :boolean, default: false
  end

  def down
    remove_column :solicituds, :locked, :boolean
  end
end
