class RemoveIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index 'meat_company_users', name: :index_meat_company_users_on_email_and_active
    add_index :meat_company_users, ["email", "active"], unique: true
  end
end
