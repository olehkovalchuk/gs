class AddPackageExpirationToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :package_expiration, :date, null: false, default: Date.current.end_of_month
  end
end
