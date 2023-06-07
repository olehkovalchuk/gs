module Admin

    module Meat
      module CompanyUserSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id
          # as_image :avatar
          def avatar
            image_path(object.avatar)
          end

        end
        class List < BeOneAdmin::Serializer
          self.sorting ={
            created_at: :created_at,
            offers_count: :offers_count,
            requests_count: :requests_count,
            chats_count: :chats_count,
          }
          hidden :id
          # as_image :avatar
          attributes :username, :company_title, :title, :email, :phone
          attribute :is_company_owner, type: :state
          attributes :offers_count, :requests_count, :chats_count, :created_at

          def chats_count
            object.incoming_chats_count + object.outgoing_chats_count
          end
          def username
            "#{object.first_name} #{object.last_name}"
          end
          def avatar
            url_for(object.avatar) if object.avatar.attached?
          end
          def created_at
            object.created_at.strftime("%d.%m.%Y %H:%M")
          end
        end
      end
    end

end

