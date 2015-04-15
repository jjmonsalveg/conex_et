class CreateEscuelaTransportes < ActiveRecord::Migration
  def change
    create_table :escuela_transportes do |t|

      #FIELDS
      t.string  :razonSocial, null:false , default:'', limit:50

      #campos para rif
      t.string  :tipo_rif, null:false, default:'',limit:1
      t.integer :rif, null:false
      t.integer :digito_rif, null:false
      #campos para rif

      t.string  :email, null:false, default:'',limit:50
      t.string  :telefono, null:false, default:'',limit:10
      t.string  :movil, default:'',limit:10
      t.string  :avenida,limit:50
      t.string  :calle, limit:30
      t.string  :urbanizacion,limit:50
      t.string  :edificio_cc,limit:20
      t.string  :local,limit:20
      t.string  :codigoET,limit:10
      t.string  :url, limit:150
      t.integer :piso
      t.integer :estado,  null:false, default:0  #0:temporal 1:alta 2:suspendido

      # t.boolean :register_status, default:false, null:false

      #REFERENCES
      t.references :ciudad   ,null:false, index: true
      t.references :parroquia,null:false, index: true
      t.references :representante_legal, null: false, index: true
      t.references :tipo_escuela, index: true

      t.timestamps
    end
    add_index :escuela_transportes, :razonSocial , unique: true
    add_index :escuela_transportes, :rif
    add_index :escuela_transportes, :digito_rif
    add_index :escuela_transportes,[:rif,:digito_rif], unique: true
    add_index :escuela_transportes,:email, unique: true
    add_index :escuela_transportes,:telefono, unique: true
    add_index :escuela_transportes,:movil, unique: true
    add_index :escuela_transportes,:codigoET, unique: true

  end
end
