class DeviseCreateFuncionarios < ActiveRecord::Migration
  def change
    create_table(:funcionarios) do |t|
      ## Database authenticatable
      t.string :login, default: "", null: false
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Email Requerido
      t.string :email, default: ""

      t.string :nombre, default: "", limit: 60
      t.string :apellido, default: "", limit: 50
      t.string :nacionalidad, default: "", limit: 1
      t.integer :cedula, default: 0
      t.text :direccion, default: ""
      t.string :sexo, default: "", limit: 1
      t.string :telefono_casa, default: "", limit: 30
      t.string :telefono_celular, default: "", limit: 30
      t.integer :estado, default: 0
      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ##UNIQUE SESSION
      t.string :unique_session_id, :limit => 20

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end
    add_index :funcionarios, :login, unique: true
    add_index :funcionarios, :reset_password_token, unique: true
  end
end
