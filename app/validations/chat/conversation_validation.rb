
module Chat
  module ConversationValidation
    class Base
      include Validation::Base
      crudify do
        # attribute :some_attr, String, default: ""
        # validates :some_attr, presence: true
      end
    end

    class CabinetList
      include Validation::Base
      attribute :page, Integer, default: 1
      attribute :current_user, Meat::CompanyUserPresenter
      validates :current_user, presence: true
    end

    class CreateDefault
      include Validation::Base
      attribute :company, Meat::Company
      validates :company, presence: true
    end

    class AddMessage
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :message, String
      attribute :file, String
      attribute :id, Integer
      attribute :skip_limit, Boolean, default: false
      attribute :sent, Boolean, default: false

      attribute :recepient_id, Integer

      attribute :file, ActionDispatch::Http::UploadedFile


      validates :current_user, presence: true
      validates :recepient_id, presence: true, if: ->(o){ o.id.to_i.zero? }
      validates :id, presence: true, if: ->(o){ o.recepient_id.to_i.zero? }
      validates :message, presence: true, unless: ->(o){ o.id.to_i.zero? }



    end


  end
end

