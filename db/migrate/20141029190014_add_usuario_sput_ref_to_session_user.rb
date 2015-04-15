class AddUsuarioSputRefToSessionUser < ActiveRecord::Migration
  def change
    add_reference :session_users, :usuario_sput, null: false
  end
end

