class AddPracticeToPostures < ActiveRecord::Migration[8.0]
  def change
    add_reference :postures, :practice, null: true, foreign_key: true
  end
end
