# == Schema Information
#
# Table name: chat_contacts
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  name       :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
