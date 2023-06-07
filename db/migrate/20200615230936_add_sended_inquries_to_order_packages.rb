class AddSendedInquriesToOrderPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :order_packages, :sended_inquries, :integer, default: 0, null: false
    add_column :meat_companies, :sended_inquries_limit, :integer, default: 1
    add_column :meat_companies, :sended_inquries_used, :integer, default: 0

    add_column :order_packages, :top_offers, :integer, default: 0, null: false
    add_column :meat_companies, :top_offers_limit, :integer, default: 1
    add_column :meat_companies, :top_offers_used, :integer, default: 0

  end
end
