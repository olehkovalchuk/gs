class ChangeDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column :meat_companies, :offers_count_limit, :integer, default: 0, null: false
    change_column :meat_companies, :requests_count_limit, :integer, default: 0, null: false
    change_column :meat_companies, :received_inquries_limit, :integer, default: 0, null: false
    change_column :meat_companies, :replyies_to_inquries_limit, :integer, default: 0, null: false
    change_column :meat_companies, :active_chats_limit, :integer, default: 0, null: false
    change_column :meat_companies, :show_infos_limit, :integer, default: 0, null: false
    change_column :meat_companies, :buyer_allerts_limit, :integer, default: 0, null: false
    change_column :meat_companies, :sub_accounts_limit, :integer, default: 0, null: false
    change_column :meat_companies, :offers_limit, :integer, default: 0, null: false
    change_column :meat_companies, :sended_inquries_limit, :integer, default: 0, null: false
    change_column :meat_companies, :top_offers_limit, :integer, default: 0, null: false
  end
end
