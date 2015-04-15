class Clase < ActiveRecord::Base
  self.establish_connection :inttt_database

  def self.clase(id_clase)
    clase = self.find_by(ID_CLASE: id_clase)
    return clase.nil? ? 'NULL': clase.NOMBRE_CLASE
  end

end