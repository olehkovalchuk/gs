class ChangeWeithType < ActiveRecord::Migration[6.0]
  def change
    change_column :meat_offers ,:weight_type, :string, limit:2
    change_column :meat_offers ,:length_type, :string, limit:2
  end
end
