class CreateMeetAlerts < ActiveRecord::Migration[6.0]
  def change
    create_table :meat_alerts do |t|
      t.integer :category_id, null:false, index: true
      t.integer :company_id, null:false, index: true
    end
  end
end
