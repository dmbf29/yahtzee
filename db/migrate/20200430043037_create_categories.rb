class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :value
      t.boolean :top_half
      t.integer :place
      t.boolean :fixed_value

      t.timestamps
    end
  end
end
