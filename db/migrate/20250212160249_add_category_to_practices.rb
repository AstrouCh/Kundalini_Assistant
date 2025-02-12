class AddCategoryToPractices < ActiveRecord::Migration[8.0]
  def change
    add_column :practices, :category, :string
  end
end
