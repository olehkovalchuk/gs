# == Schema Information
#
# Table name: chat_inquiries
#
#  id                        :bigint           not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  sender_email              :string           not null
#  title                     :string           not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  sender_company_id         :integer
#  sender_company_user_id    :integer
#  parent_id                 :integer          default(0), not null
#  receiver_email            :string           not null
#  inquirieable_id           :integer          not null
#  inquirieable_type         :string           not null
#  message                   :text             not null
#  status                    :string           default("created"), not null
#  inquiry_email             :string
#  income                    :boolean          default(TRUE)
#  phone                     :string
#  post_request              :boolean          default(FALSE)
#  country_code              :string(2)
#  phone_number              :string
#
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



