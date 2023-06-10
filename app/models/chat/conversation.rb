# == Schema Information
#
# Table name: chat_conversations
#
#  id                        :bigint           not null, primary key
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  active                    :boolean          default(TRUE)
#  deleted                   :boolean          default(TRUE)
#  has_new_messages          :boolean          default(TRUE), not null
#  with_messages             :boolean          default(FALSE)
#  sender_new_messages       :boolean          default(FALSE)
#  recipient_new_messages    :boolean          default(FALSE)
#
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


