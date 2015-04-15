class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.string :helper_path, null:false
      t.string :style, null:false
      t.string :icon, null:false
      t.string :text, null:false
      t.references :funcion_sistema, index: true, null:false

      t.timestamps
    end
  end
end
