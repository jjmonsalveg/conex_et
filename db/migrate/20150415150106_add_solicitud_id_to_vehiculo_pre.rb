class AddSolicitudIdToVehiculoPre < ActiveRecord::Migration
  def change
    add_column :vehiculo_pres, :solicitud_id, :integer
    remove_column :vehiculo_pres, :escuela_transporte_id, :integer
  end
end
