# == Schema Information
#
# Table name: chat_notifications
#
#  id                        :bigint           not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  sender_company_id         :integer          not null
#  sender_company_user_id    :integer          not null
#  recipient_company_id      :integer          not null
#  recipient_company_user_id :integer          not null
#  comment                   :string           not null
#  action                    :string           not null
#  notificable_type          :string           not null
#  notificable_id            :integer          not null
#  params                    :jsonb            not null
#  item_type                 :string
#  read                      :boolean          default(FALSE), not null
#
module Chat
  class Notification  < ApplicationRecord
    belongs_to :notificable, polymorphic: true
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



