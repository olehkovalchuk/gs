module Admin

    module Meat
      module CompanySerializer
        class Item < BeOneAdmin::Serializer
          attributes :id,:country_code,:phone,:title,:iban,:swift,:account_number,:tic,:vat,:eori, :active, :blocked, :blocked_until
          as_image :logo
          attributes :role, :bank_country, :bank, :iban, :representative, :total_emploees, :year_establishment, :plant_number, :about, :city, :address, :zip, :zip_address
          attributes :pasport_verified, :bill_verified, :moderated, :on_map, :latitude, :longitude, :markets


          attributes :passport, :bill, :package_expiration, :rating_code
          as_image :logo


          attributes :offers_count_limit, :requests_count_limit, :received_inquries_limit, :replyies_to_inquries_limit
          attributes :active_chats_limit, :show_infos_limit, :buyer_allerts_limit, :sub_accounts_limit
          attributes :top_offers_limit, :sended_inquries_limit

          attributes :offers_count_used, :requests_count_used, :received_inquries_used, :replyies_to_inquries_used
          attributes :active_chats_used, :show_infos_used, :buyer_allerts_used, :sub_accounts_used
          attributes :top_offers_used, :sended_inquries_used

          def logo
            image_path(object.logo)
          end

          def passport
            object.passport.service_url if object.passport.attached?
          end

          def bill
            image_path(object.bill, "")
          end

        end
        class List < BeOneAdmin::Serializer

          self.sorting = {
            created_at: :created_at,
            rating_code: :rating_code,
            offers_count: :offers_count,
            requests_count: :requests_count,
            managers_count: :managers_count,
            on_map: :on_map,
          }

          hidden :id
          as_image :logo
          attributes :title, :role, :rating_code, :country_title, :offers_count, :requests_count, :managers_count
          attributes :created_at
          attribute :pasport_verified, type: :state
          attribute :bill_verified, type: :state
          attribute :moderated, type: :state
          attribute :on_map, type: :state


          attribute :has_passport, type: :state
          attribute :has_bill, type: :state
          

          def has_passport
            object.passport.attached?
          end

          def created_at
            object.created_at.strftime("%d.%m.%Y %H:%M")
          end

          def has_bill
            object.bill.attached?
          end

          def chats_count
            object.outgoing_chats_count + object.incoming_chats_count
          end

          def logo
            image_path(object.logo)
          end

        end
      end
    end

end

