class CreateAseguradoras < ActiveRecord::Migration
  def change
    create_table :aseguradoras do |t|
      t.string :nombre
      t.string :rif

      t.timestamps
    end
  end
end
