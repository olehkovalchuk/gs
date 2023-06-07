module Admin

  module Order
    class ServicesController < Admin::ApplicationController
      work_with model: "::Order::Service"
      set_has_many_relations :items
      include Admin::FormHelper

      def _prepare_form_data
        {
          usage_types: form_choose.concat( ::Order::Service.usage_types.keys.map{|i| {id: i, title: i} }),
          currencies: form_choose.concat( ["EUR","USD"].map{|i| {id: i, title: i} }),
          item_types: form_choose.concat( ::Order::PaymentTransaction.item_types.keys.map{|i| {id: i, title: i} }), 
        }
      end

    end
  end

end

