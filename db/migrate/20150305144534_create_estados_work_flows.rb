class CreateEstadosWorkFlows < ActiveRecord::Migration
  def change
    create_table :estados_work_flows do |t|
      t.string :nombre, limit: 100, null:false,default:''
      t.references :Workflow, null:false
      t.timestamps
    end
    add_index :estados_work_flows , :Workflow_id
    add_index :estados_work_flows , :nombre
    add_index :estados_work_flows , [:id,:Workflow_id], unique: true
    add_index :estados_work_flows , [:nombre,:Workflow_id], unique: true
  end
end
