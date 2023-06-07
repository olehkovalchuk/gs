class StepsHabtm < ActiveRecord::Migration[6.0]
  def change

    create_table :delivery_steps_step_fields do |t|
      t.integer :field_id, null: false
      t.integer :step_id, null: false
    end

  end
end
