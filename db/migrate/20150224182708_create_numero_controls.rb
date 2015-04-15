class CreateNumeroControls < ActiveRecord::Migration
  def change
    create_table :numero_controls do |t|
      t.string :nombre
      t.integer :numero

      t.timestamps
    end
    add_index :numero_controls, :numero , unique: true
  end
end
