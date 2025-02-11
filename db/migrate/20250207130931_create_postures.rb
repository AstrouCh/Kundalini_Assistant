class CreatePostures < ActiveRecord::Migration[8.0]
  def change
    create_table :postures do |t|
      t.string :name
      t.integer :time
      t.boolean :holding_breath_ending
      t.integer :holding_breath_time

      t.timestamps
    end
  end
end
