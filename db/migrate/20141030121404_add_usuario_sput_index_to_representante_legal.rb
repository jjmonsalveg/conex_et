# -*- encoding : utf-8 -*-
class AddUsuarioSputIndexToRepresentanteLegal < ActiveRecord::Migration
  def change
    add_index  :representante_legal, :usuario_sput_id, unique: true
    add_index  :representante_legal, :session_user_id, unique: true
  end
end

