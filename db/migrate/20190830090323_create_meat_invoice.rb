class CreateMeatInvoice < ActiveRecord::Migration[6.0]

  def change

    create_table :meat_invoices do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

