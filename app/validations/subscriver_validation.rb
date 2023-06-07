class SubscriverValidation
  class Base
    include Validation::Base
    include Recaptcha::Adapters::ControllerMethods

    crudify do

      attribute :email, String
      attribute :captcha, String
      validates :email, presence: true
      # validates :email,    length: { in: 6..50 }, format:{with:/\A^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

      before_validation do |params|
        # errors.add(:captcha, "Captcha is invalid") unless verify_recaptcha( model: params, response: params.captcha )
      end
      def request;end
      def env;end


    end

  end

end
