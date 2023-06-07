class AddCertificatesToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :certificates, :integer, array:true, null:false, default:[]
  end
end
