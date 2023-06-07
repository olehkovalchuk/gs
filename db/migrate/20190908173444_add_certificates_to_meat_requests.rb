class AddCertificatesToMeatRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_requests, :certificates, :integer,array:true, default:[],null: false
    add_column :meat_requests, :documents, :integer,array:true, default:[],null: false
  end
end
