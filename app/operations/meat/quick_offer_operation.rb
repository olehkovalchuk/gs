
module Meat
  module QuickOfferOperation
    class Base 
      include Operation::Base
      crudify except: %i[create] do 
        model_name QuickOffer
      end
    end

    class Create < Base
      def perform
        pp form.images
        unless form.current_user 
          unless user = Meat::CompanyUser.find_by(email: form.email )
            password = ::BeOneCore::Password.random
            user = Meat::CompanyUserOperation::SignUp.new(
              agree: true,
              email: form.email,
              password: password,
              password_confirmation: password,
              first_name: form.email,
              last_name: form.email,
              role: 'trader',
              company_name: form.email,
              country_code: form.user_country,
              phone_number: '000000000',
              phone: '000000000',
              ip: form.ip,
              referer: form.referer,
              user_agent: form.user_agent,
              skip_captcha: true,
              reset_password_token: ::BeOneCore::Password.salt
            ).run
          end
          form.current_user = user.presenter
        end

        @model = QuickOffer.new(
          email: form.email,
          price: form.price,
          country_code: form.country_code,
          category_id: form.category_id,
          user_id: form.current_user.id,
          company_id: form.current_user.company_id,
          images: form.images
        )
        @model.save!
      end
    end
  end
end
