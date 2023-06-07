
module Chat
  class Inquiry  < ApplicationRecord
    belongs_to :inquirieable, polymorphic: true
    belongs_to :parent, class_name: "::Chat::Inquiry", foreign_key: :parent_id, optional: true

    enum status: {
      created: "created",
      sent: "sent",
      edited: "edited",
      unpayed: "unpayed"
    }

    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_company_user_id, optional: true
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id, optional: true
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_company_user_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :sender, prefix: true
    delegate :title, to: :sender_company, prefix: true
    delegate :title, to: :recipient, prefix: true
    delegate :title, to: :recipient_company, prefix: true

  end
end



