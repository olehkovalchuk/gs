class AddFiledsToUsers < ActiveRecord::Migration[6.0]
  def change

    add_column :meat_company_users, :active_offers, :integer, default: 0

    add_column :meat_company_users, :incomming_offer_views, :integer, default: 0
    add_column :meat_company_users, :incomming_uniq_offer_views, :integer, default: 0
    add_column :meat_company_users, :incomming_invoice, :integer, default: 0
    add_column :meat_company_users, :incomming_safe_deals_count, :integer, default: 0

    add_column :meat_company_users, :outgoing_offer_views, :integer, default: 0
    add_column :meat_company_users, :outgoing_uniq_offer_views, :integer, default: 0
    add_column :meat_company_users, :outgoing_invoice, :integer, default: 0
    add_column :meat_company_users, :outgoing_safe_deals_count, :integer, default: 0



    add_column :meat_companies, :active_offers, :integer, default: 0
    
    add_column :meat_companies, :incomming_offer_views, :integer, default: 0
    add_column :meat_companies, :incomming_uniq_offer_views, :integer, default: 0
    add_column :meat_companies, :incomming_invoice, :integer, default: 0
    add_column :meat_companies, :incomming_safe_deals_count, :integer, default: 0

    add_column :meat_companies, :outgoing_offer_views, :integer, default: 0
    add_column :meat_companies, :outgoing_uniq_offer_views, :integer, default: 0
    add_column :meat_companies, :outgoing_invoice, :integer, default: 0
    add_column :meat_companies, :outgoing_safe_deals_count, :integer, default: 0


  end
end

