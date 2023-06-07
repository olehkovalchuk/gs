class AddUploadedByBuyerToOrderProceses < ActiveRecord::Migration[6.0]
  def change
    add_column :order_proceses, :uploaded_by_buyer, :boolean
    add_column :order_proceses, :uploaded_by_seller, :boolean
  end
end
