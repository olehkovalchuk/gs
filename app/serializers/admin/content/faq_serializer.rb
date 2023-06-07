module Admin 
  
    module Content
      module FaqSerializer
        class Item < BeOneAdmin::Serializer
          attributes :id, :active, :category
          translated :title, :text
        end
        class List < BeOneAdmin::Serializer

          self.sorting ={
            title: :title,
            category: :category
          }

          attribute :id, type: :hidden
          attributes :title, :category
          attribute :active, type: :state
        end
      end
    end
  
end
