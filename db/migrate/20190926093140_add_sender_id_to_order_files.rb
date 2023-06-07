class AddSenderIdToOrderFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :order_files, :sender_id, :integer, null:false
    add_column :order_files, :sender_company_id, :integer, null:false
  end
end
