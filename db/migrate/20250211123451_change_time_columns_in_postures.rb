class ChangeTimeColumnsInPostures < ActiveRecord::Migration[8.0]
  def change
    change_column :postures, :time, :integer, using: 'extract(epoch from time)'.to_s
    change_column :postures, :holding_breath_time, :integer, using: 'extract(epoch from holding_breath_time)'.to_s
  end
end
