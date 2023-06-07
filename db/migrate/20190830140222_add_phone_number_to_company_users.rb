class AddPhoneNumberToCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_company_users, :phone_number, :string
    add_column :meat_company_users, :country_code, :string, limit: 2
  end
end
