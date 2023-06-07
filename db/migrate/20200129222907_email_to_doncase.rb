class EmailToDoncase < ActiveRecord::Migration[6.0]
  def change
    Meat::CompanyUser.update_all("email = LOWER(email)")
  end
end
