module Chat
  class MessageSerializer
    class List < BeOneAdmin::Serializer
      attributes :message_cls,:text, :bottom_text, :created_at, :logo

      def message_cls
        @instance_options[:current_user].company_id == self.object.sender_company_id ? 'user' : 'received'
      end

      def created_at
        format = if object.created_at < Date.today.beginning_of_day
          "%d %b %Y %H:%M"
        else
          "%H:%M"
        end
        object.created_at.strftime(format)
      end

      def bottom_text
        if self.object.file.attached?
          I18n.t("common.chat_file_name",name: self.object.file.filename, link: url_for(self.object.file) )
        elsif false
        end
      end

      def logo
        image_path(self.object.sender_company.logo)
      end

    end
  end
end
