class AddVerificatedEmailToCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_company_users, :verificated_email, :boolean, default: false, null:false
    add_column :meat_company_users, :verificated_phone, :boolean, default: false, null:false
    add_column :meat_company_users, :verification_codes ,:string, null: false, array: true, default:[]
    add_column  :meat_company_users, :verification_expire, :datetime
  end
end
