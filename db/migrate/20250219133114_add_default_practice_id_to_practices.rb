class AddDefaultPracticeIdToPractices < ActiveRecord::Migration[8.0]
  def change
    add_column :practices, :default_practice_id, :integer
  end
end
