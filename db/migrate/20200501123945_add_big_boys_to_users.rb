class AddBigBoysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :big_boys, :integer, default: 0
end
