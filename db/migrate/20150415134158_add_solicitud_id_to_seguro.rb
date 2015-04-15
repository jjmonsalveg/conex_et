class AddSolicitudIdToSeguro < ActiveRecord::Migration
  def change
    add_column :seguros, :solicitud_id, :integer
  end
end
