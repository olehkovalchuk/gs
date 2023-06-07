module Admin
  module Chat
    module SubscriberSerializer
      class Item < BeOneAdmin::Serializer
        attributes :id
      end
      class List < BeOneAdmin::Serializer
        attribute :id, type: :hidden
        attributes :email, :created_at
      end
    end
  end
end

