class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :code
      t.references :winner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
