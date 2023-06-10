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
  module ProcesSerializer
    class List < BeOneAdmin::Serializer
      attributes :id, :offer, :company, :sender, :status, :price, :item_type, :updated_at
      DATE_FORMAT = "%d %b %Y %H:%M"

      def id
        object.process_id
      end

      def offer
        {
          img: image_path(object.processable.images.first, ActionController::Base.helpers.image_url("product-s.png"), "80x80"),
          title: object.title
        }
      end

      def company
        c = @instance_options[:current_user].company_id == object.processable.company_id ? object.sender_company : object.recipient_company
        Meat::CompanySerializer::Mini.new(c,current_user: @instance_options[:current_user])
      end

      def sender
        @instance_options[:current_user].company_id == object.processable.company_id ? object.sender.presenter.user_name : object.recipient.presenter.user_name
      end

      def status
        I18n.t("common.proces_statuses.#{object.status}")
      end

      def price
        "#{object.price} #{object.currency}/MT"
      end

      def item_type
        "Deal"
      end

      def updated_at
        object.updated_at.strftime(DATE_FORMAT)
      end



    end

    class Step < ActiveModel::Serializer
      attributes :process_id, :required_fields, :id
      def process_id
        object.proces.process_id
      end
    end

    class Item < BeOneAdmin::Serializer

      attributes :recepient_company, :offer, :payment_type, :delivery, :stage, :documents, :packing
      attributes :quantity, :product_id, :title, :origin, :currency, :price , :additional_contact_person
      attributes :seller_step, :buyer_step, :process_id, :comment, :month_of_production
      attributes :status, :post_pay, :pre_pay, :destination_port, :shiping_line, :attachments, :notifications, :confirmed

      attributes :steps,:ready_for_logistic, :po_btn_disabled, :step_desc, :recepinet, :current_user, :company_details, :current_company, :is_safe


      def ready_for_logistic
        if self.seller_step
          object.uploaded_by_buyer && object.uploaded_by_seller && !object.po_signed_by_seller
        else
          object.po_signed_by_seller
        end
      end

      def po_btn_disabled
        return true if object.logistic?
        if self.seller_step
          return !object.po_confirmed_by_seller
        else
          !(object.po_confirmed_by_seller && object.po_confirmed_by_buyer && object.uploaded_by_seller)
        end
      end

      def step_desc
        return I18n.t("common.wait_for_partner_sign") if object.po_signed_by_seller && object.po_confirmed_by_buyer
        if self.seller_step
          return I18n.t("common.wait_for_partner_sign") if object.po_signed_by_seller
          if object.po_confirmed_by_seller
            if object.uploaded_by_buyer
              I18n.t("common.po_sign_desc")
            elsif object.uploaded_by_seller
              I18n.t("common.wait_for_buyer_sign")
            else
              I18n.t("common.po_prepare_sign_desc")
            end
          else
            I18n.t("common.po_negotiations_need_approve_desc")
          end
        else
          if object.po_confirmed_by_buyer && object.po_confirmed_by_seller
            if object.po_signed_by_seller
              I18n.t("common.po_sign_desc")
            else
              if object.uploaded_by_buyer
                I18n.t("common.po_wait_sign_desc")
              else
                if object.uploaded_by_seller
                  I18n.t("common.po_after_sign_desc")
                else
                  I18n.t("common.po_wait_for_seller_download")
                end

              end
            end
          else
            I18n.t("common.po_negotiations_desc")
          end
        end
      end
      def status
        I18n.t("common.proces_statuses.#{object.status}")
      end

      def recepient_company
        company = if @instance_options[:current_user].company_id == object.processable.company_id
          object.sender_company
        else
          object.recipient_company
        end
         Meat::CompanySerializer::Po.new(  company,current_user: @instance_options[:current_user] )
      end

      def company_details
        object.send("#{prefix}_company_deails").presence || Meat::CompanySerializer::Po.new(  @instance_options[:current_user].company,current_user: @instance_options[:current_user] )
      end

      def current_company
        Meat::CompanySerializer::Po.new(@instance_options[:current_user].company,current_user: @instance_options[:current_user])
      end

      def current_user
        Meat::CompanyUserSerializer::Edit.new(@instance_options[:current_user])
      end

      def recepinet
        user = if @instance_options[:current_user].company_id == object.processable.company_id
          object.sender
        else
          object.recipient
        end
        Meat::CompanyUserSerializer::Edit.new(user)
      end

      def offer
        Meat::OfferSerializer::Mini.new(object.processable, current_user: @instance_options[:current_user])
      end

      def payment_type
        {id: object.payment_type.id, title: object.payment_type.title, has_prepay: object.payment_type.has_prepay}
      end

      def packing
        object.deliver_packaging ? {id: object.deliver_packaging.id, title: object.deliver_packaging.title} : {}
      end

      def delivery
        {id: object.delivery_condition.code, title: object.delivery_condition.code, need_seller_port: object.delivery_condition.need_seller_port, need_sea_line: object.delivery_condition.need_sea_line }
      end

      def product_id
        object.processable_id
      end

      def origin
        { code: object.origin, title: object.origin_country_title }
      end

      def created_at
        object.created_at.strftime("%d %b %Y")
      end

      def seller_step
        @instance_options[:current_user].company_id == object.recipient_company_id
      end

      def buyer_step
        @instance_options[:current_user].company_id == object.sender_company_id
      end

      def additional_contact_person
        object.send("#{prefix}_additional_contact_person")
      end

      def month_of_production
        object.month_of_production.to_i.zero? ? {} : { id: object.month_of_production, title: Date::MONTHNAMES[object.month_of_production] }
      end

      def shiping_line
        object.sea_line ? {id: object.sea_line.id, title: object.sea_line.title } : nil
      end

      def destination_port
        object.port ? {code: object.port.code, title: object.port.title } : nil
      end

      def steps
        if object.logistic?
          prev = nil
          object.steps.order(position: :asc).map do |step|
            s = {
              id: step.id,
              title: step.title,
              editable: step.send("#{prefix}_step"),
              completed: step.completed,
              current: (prev && prev.completed && !step.completed || !prev && !step.completed),
              completed_at: step.completed_at&.strftime("%d %b")
            }
            prev = step
            s
          end
        else
          []
        end
      end

      def documents
        self.seller_step ? object.presenter.documents.map{|d| {id: d.id, title: d.title, need_before_sign: d.need_before_sign} } : object.documents.inject({}){|hash,id| hash[id] = true; hash }
      end

      def confirmed
        object.po_confirmed_by_seller && object.po_confirmed_by_buyer
      end

      def attachments
        object.files.order(created_at: :desc).inject({}) do |hash,file|
          id = file.document_id.to_i.zero? ? (0...8).map { (65 + rand(26)).chr }.join : file.document_id
          hash[id] =  { title: file.attachment.filename.to_s, url: url_for( file.attachment ) }
          hash
        end
      end

      def notifications
        ActiveModelSerializers::SerializableResource.new(
          object.notifications.order(created_at: :desc),
          each_serializer: Chat::NotificationSerializer::List,
          current_user: @instance_options[:current_user]
        )
      end
      private

      def prefix
        @prefix ||= @instance_options[:current_user].company_id == object.processable.company_id ? :seller : :buyer
      end



    end
  end
end

