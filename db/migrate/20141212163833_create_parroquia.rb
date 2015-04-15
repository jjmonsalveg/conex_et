class CreateParroquia < ActiveRecord::Migration
  def change
    create_table :parroquia do |t|
      t.string :nombre
      t.references :municipio, index: true

      t.timestamps
    end
  end
end
