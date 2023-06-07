class AddRatingExtndedToMeatCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_companies, :rating_extended, :jsonb, null:false, default: { authorization: 0, activity: 0, info: 0, offers: 0 }
  end
end
