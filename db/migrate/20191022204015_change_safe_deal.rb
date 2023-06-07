class ChangeSafeDeal < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:delivery_conditions, :safe_deal, false)
  end
end
