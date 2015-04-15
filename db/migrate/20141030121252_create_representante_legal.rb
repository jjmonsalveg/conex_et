# -*- encoding : utf-8 -*-
class CreateRepresentanteLegal < ActiveRecord::Migration
  def change
    create_table :representante_legal do |t|
      t.integer :estado_representante , default: 0 , null:false
      t.string :rif , limit: 10, null: false
      t.references :session_user
      t.references :usuario_sput, null: false
    end
  end
end

