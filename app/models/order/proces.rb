# == Schema Information
#
# Table name: order_proceses
#
#  id                               :bigint           not null, primary key
#  processable_type                 :string           not null
#  processable_id                   :integer          not null
#  sender_company_id                :integer          not null
#  sender_company_user_id           :integer          not null
#  recipient_company_id             :integer          not null
#  recipient_company_user_id        :integer          not null
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  process_id                       :string           not null
#  payment_type_id                  :integer
#  pre_pay                          :float
#  post_pay                         :float
#  origin                           :string(2)        not null
#  title                            :string           not null
#  quantity                         :integer          not null
#  month_of_production              :integer
#  price                            :integer          not null
#  currency                         :string(3)        not null
#  documents                        :integer          default([]), not null, is an Array
#  comment                          :text
#  delivery_code                    :string
#  shiping_line                     :string
#  destination_port                 :string
#  stage                            :string           not null
#  status                           :string           not null
#  po_signed_by_seller              :boolean          default(FALSE)
#  po_signed_by_buyer               :boolean          default(FALSE)
#  po_confirmed_by_seller           :boolean          default(FALSE)
#  po_confirmed_by_buyer            :boolean          default(FALSE)
#  own_po                           :boolean          default(FALSE)
#  packing                          :integer
#  seller_main_contact_person       :jsonb            not null
#  seller_additional_contact_person :jsonb            not null
#  buyer_main_contact_person        :jsonb            not null
#  buyer_additional_contact_person  :jsonb            not null
#  buyer_company_deails             :jsonb            not null
#  seller_company_deails            :jsonb            not null
#  is_safe                          :boolean
#  approved_for_safe                :boolean
#  uploaded_by_buyer                :boolean
#  uploaded_by_seller               :boolean
#
module Order
  class Proces  < ApplicationRecord
    self.table_name = "order_proceses"
    enum status: {
      draft: "draft",
      created: "created",
      in_progress: "in_progress",
      cancelled: "cancelled",
      completed: "completed",
      with_complain: "with_complain",
    }

    enum stage:  {
      started: "started",
      preparation: "preparation",
      logistic: "logistic",
      finished: "finished"
    }


    belongs_to :processable, polymorphic: true

    has_many :notifications, as: :notificable, class_name: "::Chat::Notification", dependent: :delete_all

    belongs_to :origin_country, class_name: "::Geo::Country", foreign_key: :origin, primary_key: :code
    belongs_to :port, class_name: "::Geo::Port", foreign_key: :destination_port, primary_key: :code, optional:true
    belongs_to :sea_line, class_name: "::Geo::SeaLine", foreign_key: :shiping_line, primary_key: :id, optional:true

    belongs_to :deliver_packaging, class_name: "::Delivery::Package", foreign_key: :packing, primary_key: :id, optional:true
    belongs_to :payment_type, class_name: "::Delivery::PaymentType", foreign_key: :payment_type_id, primary_key: :id
    belongs_to :delivery_condition, class_name: "::Delivery::Condition", foreign_key: :delivery_code, primary_key: :code


    belongs_to :sender, class_name: "::Meat::CompanyUser", foreign_key: :sender_company_user_id
    belongs_to :sender_company, class_name: "::Meat::Company", foreign_key: :sender_company_id
    belongs_to :recipient, class_name: "::Meat::CompanyUser", foreign_key: :recipient_company_user_id
    belongs_to :recipient_company, class_name: "::Meat::Company", foreign_key: :recipient_company_id

    delegate :title, to: :origin_country, prefix: true
    delegate :title, to: :port, prefix: true
    delegate :title, to: :sea_line, prefix: true
    delegate :title, to: :payment_type, prefix: true
    delegate :title, to: :deliver_packaging, prefix: true

    delegate :title, to: :sender, prefix: true
    delegate :title, to: :sender_company, prefix: true
    delegate :title, to: :recipient, prefix: true
    delegate :title, to: :recipient_company, prefix: true


    has_many :files, class_name: "::Order::File", dependent: :delete_all, foreign_key: :process_id
    has_many :steps, class_name: "::Order::Step", dependent: :delete_all, foreign_key: :process_id

  end
end



