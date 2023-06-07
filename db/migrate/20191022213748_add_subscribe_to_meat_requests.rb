class AddSubscribeToMeatRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_requests, :subscribe, :boolean, default: false
  end
end
