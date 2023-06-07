class RenameOrderProcesses < ActiveRecord::Migration[6.0]
  def change
    rename_table :order_processes, :order_proceses
    
    add_column :order_proceses, :process_id, :string, null: false
    add_column :order_proceses, :payment_type_id, :integer

    add_column :order_proceses, :pre_pay, :float
    add_column :order_proceses, :post_pay, :float


    add_column :order_proceses, :origin, :string, limit:2

    add_column :order_proceses, :title, :string

    add_column :order_proceses, :quantity, :integer
    add_column :order_proceses, :month_of_production, :integer

    add_column :order_proceses, :price, :integer
    add_column :order_proceses, :currency, :string, limit: 3

    add_column :order_proceses, :documents, :integer, array: true, default: [], null: false

    add_column :order_proceses, :comment, :text    


    add_column :order_proceses, :delivery_condition_code, :string
    add_column :order_proceses, :shiping_line, :string
    add_column :order_proceses, :prefarable_loading, :integer
    add_column :order_proceses, :destination_port, :string
    add_column :order_proceses, :inspection, :boolean, default: false
    add_column :order_proceses, :consignee, :string
    add_column :order_proceses, :notify_party, :string
    add_column :order_proceses, :telex, :string
    add_column :order_proceses, :manage, :string
    add_column :order_proceses, :receipt_person, :string

    add_column :order_proceses, :contact_persons, :jsonb, default: [], null: false 

    add_column :order_proceses, :company_deails, :jsonb, default: {}, null: false 


    add_column :order_proceses, :stage, :string, null: false
    add_column :order_proceses, :status, :string, null: false

    add_column :order_proceses, :po_signed_by_seller, :boolean, default: false
    add_column :order_proceses, :po_signed_by_buyer, :boolean, default: false

    add_column :order_proceses, :po_confirmed_by_seller, :boolean, default: false
    add_column :order_proceses, :po_confirmed_by_buyer, :boolean, default: false

    add_column :order_proceses, :own_po, :boolean, default: false

  end
end
