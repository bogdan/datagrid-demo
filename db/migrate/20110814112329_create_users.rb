class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :disabled, :null => false, :default => false
      t.string :registration_type
      t.integer :logins_count, :null => false, :default => 0
      t.datetime :registered_at

      t.timestamps
    end
  end
end
