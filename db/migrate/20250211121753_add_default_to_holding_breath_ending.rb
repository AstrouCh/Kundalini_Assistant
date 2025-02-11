class AddDefaultToHoldingBreathEnding < ActiveRecord::Migration[8.0]
  def change
    change_column_default :postures, :holding_breath_ending, false
  end
end
