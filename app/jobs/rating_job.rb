class RatingJob < ApplicationJob
  def perform
    Meat::Company.all.each do |c|
      Meat::CompanyOperation::CalculateRating.new(id:c.id).process
    end
  end
end

