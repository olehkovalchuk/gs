class SubscriptionJob < ApplicationJob
  def perform
    Meat::SubscriptionOperation::Send.new.process(skip_validation: true)
  end
end

