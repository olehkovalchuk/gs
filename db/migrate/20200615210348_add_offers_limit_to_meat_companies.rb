class AddOffersLimitToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :offers_count_limit, :integer, default: 1
    add_column :meat_companies, :offers_count_used, :integer, default: 0

    add_column :meat_companies, :requests_count_limit, :integer, default: 1
    add_column :meat_companies, :requests_count_used, :integer, default: 0

    add_column :meat_companies, :received_inquries_limit, :integer, default: 1
    add_column :meat_companies, :received_inquries_used, :integer, default: 0

    add_column :meat_companies, :replyies_to_inquries_limit, :integer, default: 1
    add_column :meat_companies, :replyies_to_inquries_used, :integer, default: 0

    add_column :meat_companies, :active_chats_limit, :integer, default: 1
    add_column :meat_companies, :active_chats_used, :integer, default: 0

    add_column :meat_companies, :show_infos_limit, :integer, default: 1
    add_column :meat_companies, :show_infos_used, :integer, default: 0

    add_column :meat_companies, :buyer_allerts_limit, :integer, default: 1
    add_column :meat_companies, :buyer_allerts_used, :integer, default: 0

    add_column :meat_companies, :sub_accounts_limit, :integer, default: 1
    add_column :meat_companies, :sub_accounts_used, :integer, default: 0

    add_column :meat_companies, :offers_limit, :integer, default: 1
    add_column :meat_companies, :offers_used, :integer, default: 0

  end
end
