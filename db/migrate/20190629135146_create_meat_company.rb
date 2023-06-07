class CreateMeatCompany < ActiveRecord::Migration[6.0]

  def change
    
    create_table :meat_companies do |t|

      t.integer :processes_count, null:false, default:0
      t.integer :offers_count, null:false, default:0
      t.integer :requests_count, null:false, default:0
      t.integer :managers_count, null:false, default:0
      t.integer :chats_count, null:false, default:0
      t.integer :new_messages_count, null:false, default:0

      t.integer :rating, null:false, default:0
      t.string :rating_code, null:false, default: ::Meat::Company::DEFAULT_RATING_CODE

      t.string :country_code, limit: 2
      t.string :phone
      t.string :title, null:false
      t.string :seo_name, null:false,index: true, unique: true


      t.string :iban
      t.string :swift
      t.string :account_number

      t.string :tic
      t.string :vat
      t.string :eori



      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end

