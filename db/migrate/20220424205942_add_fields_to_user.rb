class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :country, :string
    add_column :users, :adress, :string
    add_column :users, :phone, :string
    add_column :users, :bank_account, :string
  end
end
