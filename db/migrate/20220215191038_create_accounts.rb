class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :password
      t.string :uuid
      t.integer :provider

      t.timestamps
    end
  end
end
