class ChnageProcesses < ActiveRecord::Migration[6.0]
  def change
    change_column :order_proceses, :origin, :string, limit:2, null: false
    change_column :order_proceses, :title, :string, null: false
    change_column :order_proceses, :quantity, :integer, null: false
    change_column :order_proceses, :price, :integer, null: false
    change_column :order_proceses, :currency, :string, null: false,limit:3

    rename_column :order_proceses, :delivery_condition_code, :delivery_code

    remove_column :order_proceses, :prefarable_loading
    remove_column :order_proceses, :inspection
    remove_column :order_proceses, :consignee
    remove_column :order_proceses, :notify_party
    remove_column :order_proceses, :telex
    remove_column :order_proceses, :manage
    remove_column :order_proceses, :receipt_person
    remove_column :order_proceses, :contact_persons
    remove_column :order_proceses, :company_deails


    add_column :order_proceses, :packing, :integer
    add_column :order_proceses, :seller_main_contact_person, :jsonb, null: false, default: {}
    add_column :order_proceses, :seller_additional_contact_person, :jsonb, null: false, default: {}
    add_column :order_proceses, :buyer_main_contact_person, :jsonb, null: false, default: {}
    add_column :order_proceses, :buyer_additional_contact_person, :jsonb, null: false, default: {}

    add_column :order_proceses, :buyer_company_deails, :jsonb, null: false, default: {}
    add_column :order_proceses, :seller_company_deails, :jsonb, null: false, default: {}
  end
end
