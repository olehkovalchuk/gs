module Chat
  module ContactSerializer
    class List < BeOneAdmin::Serializer
      attributes :email, :name, :created_at

      def created_at
        object.created_at.to_s(:db)
      end
    end
    class Item < BeOneAdmin::Serializer
      attributes :id, :text
    end
  end
end
