class AddFieldsRegistrationToRepresentanteLegal < ActiveRecord::Migration
  def change
    add_column :representante_legal, :doc_rif, :string, null: false
    add_index :representante_legal, :doc_rif
    add_column :representante_legal, :doc_gaceta_naturalizacion, :string
    add_index :representante_legal, :doc_gaceta_naturalizacion
    add_column :representante_legal, :doc_cedula, :string, null: false
    add_index :representante_legal, :doc_cedula
    add_column :representante_legal, :direccion, :string, null: false
  end
end