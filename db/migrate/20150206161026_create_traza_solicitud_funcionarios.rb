class CreateTrazaSolicitudFuncionarios < ActiveRecord::Migration
  def change
    create_table :traza_solicitud_funcionarios do |t|
      t.belongs_to :solicitud, index: true, null:false
      t.belongs_to :funcionario, index:true, null: false
      t.string :observacion
      t.integer :estado_inicial, null:false
      t.integer :estado_final  , null:false
      t.inet    :ip_funcionario
      t.timestamps
    end
  end
end
