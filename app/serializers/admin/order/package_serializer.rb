module Admin 
  
    module Order
      module PackageSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :is_best, :map_access, :rating_code, :price
          attributes :currency, :description, :offers_count, :requests_count, :received_inquries, :replyies_to_inquries
          attributes :active_chats, :show_infos, :buyer_allerts, :sub_accounts, :performance, :reports, :offline_packages
          attributes :top_offers, :sended_inquries, :default, :file_link, :file_name, :days
          translated :title

          def file_link
            self.object.file.attached? ? rails_blob_path(self.object.file, disposition: 'preview')  : nil
          end

          def file_name
            self.object.file.attached? ? self.object.file.name : nil
          end
        end
        class List < BeOneAdmin::Serializer
          attribute :id, type: :hidden
          attributes :title, :price, :description
          with_type :state, :is_best
          with_type :state, :active
          with_type :default, :active

        end
      end
    end
  
end

