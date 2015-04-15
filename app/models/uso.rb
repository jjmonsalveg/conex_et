# == Schema Information
#
# Table name: usos
#
#  id         :integer          not null, primary key
#  ID_USO     :string
#  NOMBRE_USO :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Uso < ActiveRecord::Base
  self.establish_connection :inttt_database

  def self.uso(id_uso)
    uso = self.find_by(ID_USO: id_uso)
    return uso.nil? ? 'NULL': uso.NOMBRE_USO
  end

end
