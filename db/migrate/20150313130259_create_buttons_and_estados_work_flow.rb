class CreateButtonsAndEstadosWorkFlow < ActiveRecord::Migration
  def change
    create_table :buttons_estados_work_flows , :id => false do |t|
      t.belongs_to :button
      t.belongs_to :estados_work_flow
    end
    add_index :buttons_estados_work_flows,:button_id, name: 'index_button'
    add_index :buttons_estados_work_flows,:estados_work_flow_id, name: 'index_estate_wf'
  end
end
