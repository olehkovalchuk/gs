class AddOtpSecretKeyToCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_company_users, :otp_secret_key, :string

    Meat::CompanyUser.find_each { |user| user.update_attribute(:otp_secret_key, Meat::CompanyUser.otp_random_secret) }

  end
end
