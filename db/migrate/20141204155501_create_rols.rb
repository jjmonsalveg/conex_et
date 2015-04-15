class CreateRols < ActiveRecord::Migration
  def change
    create_table :rols do |t|
      t.string :nombre, limit: 50, default: "", null: false

      t.timestamps
    end
  end
end
