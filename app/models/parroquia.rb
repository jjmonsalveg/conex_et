# == Schema Information
#
# Table name: parroquia
#
#  id           :integer          not null, primary key
#  nombre       :string(255)
#  municipio_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_parroquia_on_municipio_id  (municipio_id)
#

class Parroquia < ActiveRecord::Base
  belongs_to :municipio
end
