# require 'recaptcha/verify'
module Meat
  module CompanyUserValidation
    class Base
      include Validation::Base
      crudify except: [:create] do
        attribute :country_code, String
        attribute :phone, String
        attribute :phone_number, String
        attribute :first_name, String
        attribute :last_name, String
        attribute :title, String
        attribute :email, String


        attribute :is_company_owner, Boolean, default: false
        attribute :eori, String
        attribute :avatar
        attribute :active, Boolean, default: true
        attribute :blocked, Boolean, default: false
        attribute :blocked_until, String


        validates :email, uniqueness: true
        validates :first_name, :last_name, :phone, :title, :email, :country_code, :phone_number,  presence: true
        validates :blocked_until, presence: true, if: ->(s){ s.blocked.presence }

        before_validation do |params|
          params.email.downcase!
          params.blocked_until = nil unless params.blocked.presence
        end

      end
    end

    class Create < Base
      attribute :company_id, Integer
      validates :company_id, presence: true
    end

    class ReadItem
      include Validation::Base
      attribute :id, Integer
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
      validates :id, presence: true

    end

    class UpdateMember
      include Validation::Base

      attribute :country_code, String
      attribute :id, Integer
      attribute :phone, String
      attribute :phone_number, String
      attribute :first_name, String
      attribute :last_name, String
      attribute :title, String
      attribute :email, String
      attribute :avatar, ActionDispatch::Http::UploadedFile

      attribute :current_user, Meat::CompanyUserPresenter
      validates :email, uniqueness: true
      validates :current_user, presence: true
      validates :id, :first_name, :last_name, :phone, :title, :email,  :country_code, :phone_number,  presence: true

    end

    class SignUp
      include Validation::Base
      include Recaptcha::Adapters::ControllerMethods
      attribute :agree, Boolean, default: false

      attribute :email, String
      attribute :password, String
      attribute :password_confirmation, String

      attribute :first_name, String
      attribute :last_name, String
      attribute :role, String
      attribute :company_name, String
      attribute :country_code, String
      attribute :phone_number, String
      attribute :phone, String
      attribute :captcha, String
      attribute :ip, String
      attribute :referer, String
      attribute :user_agent, String
      attribute :reset_password_token, String
      attribute :without_mailer, Boolean, default: false
      attribute :skip_captcha, Boolean, default: false

      attribute :current_user, Meat::CompanyUserPresenter

      validates :password, confirmation: true
      validates :agree, :last_name, :first_name, :country_code, :company_name, :phone, :password_confirmation, :email, :password, presence: true

      # before_validation do |params|
      #   params.email.downcase!
      #   unless params.without_mailer || params.skip_captcha
      #     errors.add(:captcha, "Captcha is invalid") unless verify_recaptcha( model: params, response: params.captcha )
      #   end
      # end

      def request;end
      def env;end


    end

    class SignIn
      include Validation::Base
      attribute :email, String
      attribute :password, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :referer, String
      attribute :current_user, Meat::CompanyUserPresenter

      validates :email, :password, :ip, presence: true
      validates :email,    length: { in: 6..50 }, format:{with:/\A^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
      validates :password, length: { in: 5..20 }

      before_validation do |params|
        params.email.downcase!
      end

    end

    class Logout
      include Validation::Base
      attribute :token, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :current_user, Meat::CompanyUser

      validates :current_user, :token, :ip, presence: true
    end

    class ResetPassword
      include Validation::Base
      attribute :token, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :referer, String
      attribute :current_user, Meat::CompanyUserPresenter

      validates :token, :ip, presence: true
    end


    class ChangePassword
      include Validation::Base
      attribute :token, String
      attribute :password, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :referer, String
      attribute :password_confirmation, String
      validates :token, :password, :password_confirmation, presence: true
      validates :password, confirmation: true
    end

    class Restore
      include Validation::Base
      include Recaptcha::Adapters::ControllerMethods
      attribute :email, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :referer, String
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :captcha, String
      validates :email, :ip, presence: true
      attribute :skip_captcha, Boolean, default: false

      before_validation do |params|
        unless params.skip_captcha
          errors.add(:captcha, "Captcha is invalid") unless verify_recaptcha( model: params, response: params.captcha )
        end
      end

      def request;end
      def env;end

    end

    class Authentificate
      include Validation::Base
      attribute :token, String
      attribute :ip, String
      attribute :user_agent, String

      validates :token, :ip, presence: true
    end

    class Verify
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :code, String
      attribute :ip, String
      attribute :user_agent, String
      attribute :referer, String
      attribute :type, String, default: :email
      validates :code, :type, presence: true
    end

    class ResendVerify
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true

    end


  end
end


