class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.string :name

      t.timestamps
    end

    add_column :projects, :account_id, :integer
  end
end
