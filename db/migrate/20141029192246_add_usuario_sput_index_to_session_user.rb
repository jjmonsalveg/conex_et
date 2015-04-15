# -*- encoding : utf-8 -*-
class AddUsuarioSputIndexToSessionUser < ActiveRecord::Migration
  def change
    add_index  :session_users, :usuario_sput_id, unique: true
  end
end

