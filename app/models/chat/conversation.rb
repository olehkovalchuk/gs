
module Chat
  class Conversation  < ApplicationRecord
    has_many :messages, foreign_key: :conversation_id
    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_company_user_id
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_company_user_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :sender, prefix: true, allow_nil: true
    delegate :title, to: :sender_company, prefix: true, allow_nil: true
    delegate :title, to: :recipient, prefix: true, allow_nil: true
    delegate :title, to: :recipient_company, prefix: true, allow_nil: true
  end
end


