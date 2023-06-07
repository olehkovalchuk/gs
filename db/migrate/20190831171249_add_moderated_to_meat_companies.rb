class AddModeratedToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :moderated, :boolean, default: true
    add_column :meat_companies, :on_map, :boolean, default: false
    add_column :meat_companies, :latitude, :float, default: 0.0, null:false
    add_column :meat_companies, :longitude, :float, default: 0.0, null:false

    add_column :meat_bids, :active, :boolean, default: true
    add_column :chat_conversations, :active, :boolean, default: true
    add_column :chat_conversations, :deleted, :boolean, default: true


    add_column :meat_company_users, :deleted, :boolean, default: false

  end
end
