class AddApprovedForSafeToOrderProceses < ActiveRecord::Migration[6.0]
  def change
    add_column :order_proceses, :approved_for_safe, :boolean
    ::Setting.create(code: "registration_message", value: "Default registration message")
    ::Setting.create(code: "admin_company_id", value: Meat::Company.first&.id.to_i )
  end
end
