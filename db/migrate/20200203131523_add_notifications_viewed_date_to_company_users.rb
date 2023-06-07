class AddNotificationsViewedDateToCompanyUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_company_users, :notifications_viewed_date, :datetime
    add_column :meat_company_users, :new_notifications_count, :integer, default: 0
  end
end
