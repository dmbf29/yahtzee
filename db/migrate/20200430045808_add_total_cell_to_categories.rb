class AddTotalCellToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :total_cell, :boolean, default: false
  end
end
