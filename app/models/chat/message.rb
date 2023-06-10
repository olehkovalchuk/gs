# == Schema Information
#
# Table name: chat_messages
#
#  id                   :bigint           not null, primary key
#  sender_id            :integer          not null
#  recipient_id         :integer          not null
#  conversation_id      :integer          not null
#  text                 :text             not null
#  readed               :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  sender_company_id    :integer
#  recipient_company_id :integer
#  status               :string           default("sent"), not null
#
module Chat
  class Message  < ApplicationRecord
    belongs_to :conversation

    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_id
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :sender, prefix: true, allow_nil: true
    delegate :title, to: :sender_company, prefix: true, allow_nil: true
    delegate :title, to: :recipient, prefix: true, allow_nil: true
    delegate :title, to: :recipient_company, prefix: true, allow_nil: true

    has_one_attached :file

    enum status: {
        created: 'created',
        sent: 'sent'
    }
  end
end



