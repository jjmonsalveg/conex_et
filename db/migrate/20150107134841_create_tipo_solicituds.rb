class CreateTipoSolicituds < ActiveRecord::Migration
  def change
    create_table :tipo_solicituds do |t|
      t.string :nombre, default: "", limit: 35
      t.string :descripcion, default: ""
      t.timestamps

    end
    add_index :tipo_solicituds, :nombre, unique: true
  end
end
