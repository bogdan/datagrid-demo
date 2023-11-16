class DbStructure < ActiveRecord::Migration[7.1]
  def change

    drop_table :users, if_exists: true
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :disabled, :null => false, :default => false
      t.string :registration_type
      t.integer :logins_count, :null => false, :default => 0
      t.datetime :registered_at

      t.timestamps
    end
    drop_table :time_entries, if_exists: true
    create_table :time_entries do |t|
      t.integer :user_id
      t.integer :project_id
      t.float :hours
      t.date :date
    end

    drop_table :projects, if_exists: true
    create_table :projects do |t|
      t.string :name
      t.integer :account_id

      t.timestamps
    end
    drop_table :accounts, if_exists: true
    create_table :accounts do |t|
      t.string :name

      t.timestamps
    end

    if connection.adapter_name.downcase.to_sym == :postgresql

      execute <<-s
create index date_year on time_entries (extract(year from date))
      s
      execute <<-s
create index date_month on time_entries (extract(month from date))
      s
    end

  end
end
