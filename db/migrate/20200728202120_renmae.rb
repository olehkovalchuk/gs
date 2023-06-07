class Renmae < ActiveRecord::Migration[6.0]
  def change
    rename_column :traffic_sources, :title, :name
  end
end
