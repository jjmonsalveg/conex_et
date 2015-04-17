# == Schema Information
#
# Table name: aseguradoras
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  rif        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Aseguradora < ActiveRecord::Base
end
