module Chat
  module MessageValidation
    class Base
      include Validation::Base
      crudify except: %i[update] do
        attribute :current_user, Meat::CompanyUserPresenter
        attribute :conversation, Chat::Conversation
        attribute :message, String
        attribute :status, String, default: 'created'
        attribute :file, ActionDispatch::Http::UploadedFile
        validates :current_user, :conversation, :message, presence: true
      end
    end

    class Update
      include Validation::Base
      attribute :id, Integer
      attribute :text, String
      attribute :status, String
      validates :text, :id, :status, presence: true
    end

    class CabinetList
      include Validation::Base
      attribute :current_user, Meat::CompanyUserPresenter
      attribute :id, Integer
      validates :current_user, :id, presence: true
    end
  end
end
