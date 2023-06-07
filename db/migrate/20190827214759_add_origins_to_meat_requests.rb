class AddOriginsToMeatRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_requests, :origins, :string, array:true, null:false, default:[]
  end
end
