# == Schema Information
#
# Table name: tipo_solicituds
#
#  id          :integer          not null, primary key
#  nombre      :string(35)       default("")
#  descripcion :string(255)      default("")
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_tipo_solicituds_on_nombre  (nombre) UNIQUE
#

class TipoSolicitud < ActiveRecord::Base
  has_many  :solicituds , dependent: :destroy
  has_many  :vistas     , dependent: :destroy
  has_one   :work_flow  , dependent: :destroy, foreign_key: 'TipoSolicitud_id'
end
