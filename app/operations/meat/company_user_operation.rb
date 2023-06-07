module Meat
  module CompanyUserOperation
    class Base
      include Operation::Base
      crudify do
        model_name CompanyUser
      end
    end

    class Authentificate < Base
      validate_with Meat::CompanyUserValidation::Authentificate
      def perform
        Meat::CompanyUser.authenticate_with_token(form.token, form.ip, form.user_agent)
      end
    end

    class UpdateMember < Read
      validate_with Meat::CompanyUserValidation::UpdateMember
      def perform
        add_error!(:access_denided, "Access dined") if @model.company_id != form.current_user.company_id && form.current_user.is_company_owner || !form.current_user.is_company_owner && @model.id != form.current_user.id
        operation = Update.new(form.attributes)
        operation.errors.each_pair{|k,v| add_error!(k,v)} unless operation.process
        true
      end
    end

    class ReadItem < Read
      validate_with Meat::CompanyUserValidation::ReadItem
      def perform
        add_error!(:access_denided, "Access dined") if @model.company_id != form.current_user.company_id && form.current_user.is_company_owner || !form.current_user.is_company_owner && @model.id != form.current_user.id
        operation = Read.new(form.attributes)
        operation.errors.each_pair{|k,v| add_error!(k,v)} unless operation.process
        operation.model
      end
    end

    class UpdateMessages < Read
      validate_with Meat::CompanyUserValidation::Read
      def perform
        a = @model.created_conversations.map do |c|
          c.presenter.is_sender?(@model) ? c.sender_new_messages : c.recipient_new_messages
        end.reject(&:blank?).count
        b = @model.received_conversations.map do |c|
          c.presenter.is_sender?(@model) ? c.sender_new_messages : c.recipient_new_messages
        end.reject(&:blank?).count
        @model.update(new_messages_count: (a + b) )
      end
    end


    class UpdateNotifications < Read
      validate_with Meat::CompanyUserValidation::Read
      def perform
        @model.update(new_notifications_count: @model.company.notifications.where( read: false ).count )
      end
    end

    class SignUp < Base
      validate_with Meat::CompanyUserValidation::SignUp
      def perform

        with_transaction do
          Thread.current[:skip_captcha] = true
          # add_error!(:already_logged_in, "Already logged in") if form.current_user

          if @model = Meat::CompanyUser.where(email: form.email).take
            return true
          end
          operation = Meat::CompanyOperation::Create.new(
            country_code: form.country_code,
            phone: form.phone,
            title: form.company_name,
            role: form.role,
            rating_code: "bronze",
            phone_number: form.phone_number,
            seo_name: ::GetSeoNameOperation.(klass: "Meat::Company", title: form.company_name),
          )

          ::KibanaLogger.push("registration", { current_email: form.email, current_company: form.company_name, company_role: form.role, company_country_code: form.country_code  } )

          operation.errors.each_pair{|k,v| add_error!(k,v) } unless operation.process
          operation = Meat::CompanyOperation::AddMember.new(
            id: operation.model.id,
            email: form.email,
            first_name: form.first_name,
            last_name: form.last_name,
            password: form.password,
            phone: form.phone,
            country_code: form.country_code,
            phone_number: form.phone_number,
            is_company_owner: true,
            without_mailer: form.without_mailer,
            skip_limit: true,
            reset_password_token: form.reset_password_token
          )
          operation.errors.each_pair{|k,v| add_error!(k,v) } unless @model = operation.process

          trigger :assign_package, @model, form

          token = @model.signin(form.ip, form.user_agent, form.referer) unless form.without_mailer

          ::Chat::ConversationOperation::CreateDefault.new(company: @model.company).process

          @model.increment!(:signins_count, 1) unless form.without_mailer

          return token
        end
      end
    end

    class SignIn < Base

      BLOCK_TIME = 1.hour
      MAX_ATTEMPTS = 15

      validate_with Meat::CompanyUserValidation::SignIn
      def perform

        # add_error!(:already_logged_in) if form.current_user

        if @model = Meat::CompanyUser.where(email: form.email).take
          if @model.blocked
            ::KibanaLogger.push("auth_error", { error_message: "blocked" ,current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            add_error!(:blocked,{blocked_until: @model.blocked_until})
          elsif !@model.active
            add_error!(:deactivated)
          elsif @model.authenticate(form.password)
            ::KibanaLogger.push("auth", { current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            @model.update!(wrong_password_attempts: 0)
            token = @model.signin(form.ip, form.user_agent, form.referer)
            @model.increment!(:signins_count, 1)
            return token
          elsif @model.authenticate_otp(form.password)

            @model.update!(wrong_password_attempts: 0)
            token = @model.signin(form.ip, form.user_agent, form.referer)
            return token
          else
            ::KibanaLogger.push("auth_error", { error_message: "wrong_password" ,current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            @model.increment!(:wrong_password_attempts)
            attempts_left = MAX_ATTEMPTS - @model.wrong_password_attempts
            if attempts_left > 0
              add_error!(:wrong_credentials,{attempts_left: attempts_left})
            else
              blocked_until = Time.zone.now + BLOCK_TIME
              @model.update!(blocked: true, blocked_until: blocked_until)
              add_error!(:blocked,{blocked_until: @model.blocked_until})
            end
          end
        else
          ::KibanaLogger.push("auth_error", { error_message: "wrong_email" ,current_email: form.email } )
          add_error!(:unknown_user)
        end
      end
    end

    class Logout < Base
      validate_with Meat::CompanyUserValidation::Logout
      def perform
        form.current_user.signout(form.token, form.ip, form.user_agent)
      end
    end

    class Verify < Base
      validate_with Meat::CompanyUserValidation::Verify
      def perform
        if @model = (form.current_user || Meat::CompanyUser.where(":code = ANY(verification_codes)", code: form.code).last)
          if @model.verification_codes.include?(form.code)
            @model.update( :"verificated_#{form.type}" => true )
            @model.update(verification_codes: [])
          end
        end
        add_error!(:wrong_verification) unless @model
        return @model.signin(form.ip, form.user_agent, form.referer)
      end
    end

    class ResendVerify < Base
      validate_with Meat::CompanyUserValidation::ResendVerify
      def perform
        code = SecureRandom.hex(10)
        form.current_user.update(verification_codes: form.current_user.verification_codes.push(code), verification_expire: Time.zone.now + 1.hour )
        ::UserMailer.verify(form.current_user.object, code).send(Rails.env.development? ? :deliver_now : :deliver_later )
        return true
      end
    end


    class Restore < Base
      RESET_TIME = 2.hours
      def perform
        Thread.current[:skip_captcha] = true
        if @model = Meat::CompanyUser.where(email: form.email).take
          if @model.blocked
            ::KibanaLogger.push("restore_error", { error_message: "blocked" ,current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            add_error!(:blocked,{blocked_until: @model.blocked_until})
          elsif !@model.active
            ::KibanaLogger.push("restore_error", { error_message: "deactivated" ,current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            add_error!(:deactivated)
          elsif @model.reset_password_expire_at && @model.reset_password_expire_at > DateTime.now
            ::KibanaLogger.push("restore_error", { error_message: "already_delivered" ,current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            add_error!(:already_delivered)
          elsif @model.update_attributes( reset_password_token: ::BeOneCore::Password.salt, reset_password_expire_at: Time.zone.now + RESET_TIME  )
            ::KibanaLogger.push("restore", { current_email: form.email, current_company: @model.company.title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
            ::UserMailer.remind_password(@model).send(Rails.env.development? ? :deliver_now : :deliver_later )
            return true
          else
            ::KibanaLogger.push("restore_error", { error_message: "wrong_email" ,current_email: form.email } )
            add_error!(:invalid_user)
          end
        else
          add_error!(:unregistered)
        end
      end
    end

    class ResetPassword < Base
      def perform
        if @model = Meat::CompanyUser.where(reset_password_token: form.token).take
          password = ::BeOneCore::Password.random
          @model.update_attributes!( password: password, reset_password_token:nil, reset_password_expire_at:nil, blocked: false, blocked_until: nil )
          ::UserMailer.change_password(@model, password).send(Rails.env.development? ? :deliver_now : :deliver_later )
          return true
        else
          add_error!(:wrong_or_expired_code)
        end
        return false
      end
    end

    class ChangePassword < Base
      def perform
        if @model = Meat::CompanyUser.where(reset_password_token: form.token).take
          ::KibanaLogger.push("password_change", { current_email: @model.email ,current_company: @model.company_title, company_role: @model.company.role, company_country_code: @model.company.country_code  } )
          add_error!(:wrong_or_expired_code) if @model.reset_password_expire_at < Time.zone.now
          @model.update_attributes!( password: form.password, reset_password_token:nil, reset_password_expire_at:nil, blocked: false, blocked_until: nil )
          ::UserMailer.change_password(@model, form.password).send(Rails.env.development? ? :deliver_now : :deliver_later )
          token = @model.signin(form.ip, form.user_agent, form.referer)
          return token
        else
          add_error!(:wrong_or_expired_code)
        end
        return false
      end
    end

    class CheckResetPassword < Base
      validate_with ::Meat::CompanyUserValidation::ResetPassword
      def perform
        if @model = Meat::CompanyUser.where(reset_password_token: form.token).take
          add_error!(:wrong_or_expired_code) if @model.reset_password_expire_at < Time.zone.now
        else
          add_error!(:wrong_or_expired_code)
        end
        return true
      end
    end



    class Chart < Base
      validate_with Meat::CompanyValidation::Chart
      def perform
        form.current_user
      end
    end

  end
end
















