class AddDeletedAtToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :deleted_at, :datetime
    add_index :submissions, :deleted_at
  end
end
