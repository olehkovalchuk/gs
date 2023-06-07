class AddBlockedUntilToMeatCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :blocked_until, :datetime
    add_column :meat_companies, :active, :boolean, default: true
    add_column :meat_companies, :blocked, :boolean, default: false
  end
end
