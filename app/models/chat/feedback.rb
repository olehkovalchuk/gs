# == Schema Information
#
# Table name: chat_feedbacks
#
#  id                        :bigint           not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  text                      :text
#  rating                    :integer          default(0), not null
#  rating_extended           :jsonb            not null
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  active                    :boolean          default(TRUE)
#  deleted                   :boolean          default(TRUE)
#
module Chat
  class Feedback  < ApplicationRecord
    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_company_user_id
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_company_user_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :sender, prefix: true
    delegate :title, to: :sender_company, prefix: true
    delegate :title, to: :recipient, prefix: true
    delegate :title, to: :recipient_company, prefix: true
  end
end



