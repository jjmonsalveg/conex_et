class CreateTipoEscuelas < ActiveRecord::Migration
  def change
    create_table :tipo_escuelas do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
