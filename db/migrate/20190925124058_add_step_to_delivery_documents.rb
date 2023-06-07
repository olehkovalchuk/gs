class AddStepToDeliveryDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_documents, :need_before_sign, :boolean
  end
end
