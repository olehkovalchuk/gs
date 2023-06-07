class AddIncomeChatsCountToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :incoming_chats_count, :integer, null:false, default:0
    add_column :meat_company_users, :incoming_chats_count, :integer, null:false, default:0
    add_column :meat_companies, :outgoing_chats_count, :integer, null:false, default:0
    add_column :meat_company_users, :outgoing_chats_count, :integer, null:false, default:0

    remove_column :meat_companies, :chats_count ,:integer
    remove_column :meat_company_users, :chats_count ,:integer
    remove_column :meat_company_users, :managers_count ,:integer
  end
end
