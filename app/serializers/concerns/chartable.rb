module Chartable
  extend ActiveSupport::Concern

  included do
    attributes :chart_in, :chart_out
    def chart_in
      fileds = %w(bids_in_count incoming_chats_count active_offers incomming_offer_views incomming_uniq_offer_views incomming_invoice incomming_safe_deals_count)
      
      {
        data: fileds.map{|f| (1..100).to_a.sample },
        labels: fileds.map{|f| I18n.t("common.chart.#{f}") }
      }
      # [
      #   {value: object.bids_in_count, label:   },
      #   {value: object.incoming_chats_count, label: I18n.t("common.chart.incoming_chats_count") },
      #   {value: object.active_offers, label: I18n.t("common.chart.active_offers")   }, #todo
      #   {value: object.incomming_offer_views, label: I18n.t("common.chart.incomming_offer_views")   },  #todo
      #   {value: object.incomming_uniq_offer_views, label: I18n.t("common.chart.incomming_uniq_offer_views")   },  #todo
      #   {value: object.incomming_invoice, label: I18n.t("common.chart.incomming_invoice")   },  #todo
      #   {value: object.incomming_safe_deals_count, label: I18n.t("common.chart.incomming_safe_deals_count")   }  #todo
      # ]
    end

    def chart_out
      fileds = %w(bids_out_count outgoing_chats_count outgoing_offer_views outgoing_uniq_offer_views outgoing_invoice outgoing_safe_deals_count)
      
      {
        data: fileds.map{|f| object.send(f) },
        labels: fileds.map{|f| I18n.t("common.chart.#{f}") }
      }


      # [
      #   {value: object.bids_out_count, label: I18n.t("common.chart.bids_out_count")   },
      #   {value: object.outgoing_chats_count, label: I18n.t("common.chart.outgoing_chats_count")   },
      #   {value: object.outgoing_offer_views, label: I18n.t("common.chart.outgoing_offer_views")   },  #todo
      #   {value: object.outgoing_uniq_offer_views, label: I18n.t("common.chart.outgoing_uniq_offer_views")   },  #todo
      #   {value: object.outgoing_invoice, label: I18n.t("common.chart.outgoing_invoice")   },  #todo
      #   {value: object.outgoing_safe_deals_count, label: I18n.t("common.chart.outgoing_safe_deals_count")   }  #todo
      # ]
    end
  end
end


