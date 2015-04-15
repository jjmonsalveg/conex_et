# == Schema Information
#
# Table name: colors
#
#  id           :integer          not null, primary key
#  ID_COLOR     :string
#  NOMBRE_COLOR :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Color < ActiveRecord::Base
  self.establish_connection :inttt_database

  def self.color(id_color)
    color = self.find_by(ID_COLOR: id_color)
    return color.nil? ? 'NULL': color.NOMBRE_COLOR
  end

end
