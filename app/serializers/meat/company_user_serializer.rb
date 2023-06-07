module Meat
  module CompanyUserSerializer
    class Base < BeOneAdmin::Serializer
      attributes :id, :avatar, :user_name, :new_messages_count, :can_add_member, :company_id, :processes_count, :offers_count, :requests_count, :is_company_owner, :alert_titles

      def avatar
        image_path(object.avatar, ActionController::Base.helpers.image_url("avatar.png"), "110x110")
      end

      def user_name
        object.presenter.user_name
      end

      def can_add_member
        object.presenter.can_add_member?
      end

      def alert_titles
        object.company&.alerts&.map(&:category_title) || []
      end

    end

    class List < Base
       attributes :id, :title, :user_name, :avatar


      def user_name
        "#{object.first_name} #{object.last_name}"
      end

    end


    class Charts < ActiveModel::Serializer
      include Chartable
    end

    class Full < Base
      attributes :id, :title, :first_name, :last_name, :phone, :email, :is_company_owner, :company_title

      attributes :processes_count, :offers_count, :requests_count, :country_code, :phone_number, :company

      def company
        Meat::CompanySerializer::Cabinet.new(object.company, current_user: object)
      end

      include Chartable

    end

    class Edit < BeOneAdmin::Serializer
      attributes :id, :avatar, :first_name, :last_name, :title, :phone_number, :country_code, :email, :phone, :user_name

      def avatar
        image_path(object.avatar, ActionController::Base.helpers.image_url("user.png"), "236x236")
      end
      def user_name
        object.presenter.user_name
      end
    end
  end
end


