class ChangeUserIdInPractices < ActiveRecord::Migration[6.0]
  def change
    change_column_null :practices, :user_id, true
  end
end
