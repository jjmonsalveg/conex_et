# == Schema Information
#
# Table name: numero_controls
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  numero     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_numero_controls_on_numero  (numero) UNIQUE
#

class NumeroControl < ActiveRecord::Base

  def self.set_last(nombre)
    NumeroControl.create!(nombre: nombre, numero: NumeroControl.last.numero + 1)
  end

end
