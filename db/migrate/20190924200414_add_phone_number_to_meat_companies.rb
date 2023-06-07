class AddPhoneNumberToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :phone_number, :string
  end
end
