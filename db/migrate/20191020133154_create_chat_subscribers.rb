class CreateChatSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :email, null:false, index: true
      t.timestamps
    end
  end
end
