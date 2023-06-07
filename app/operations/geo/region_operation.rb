
module Geo
  module RegionOperation
    class Base
      include Operation::Base
      crudify do
        model_name Region
      end
    end

    class FilterTree < Base
      def perform
        Geo::Region.send(form.active_type).order(code: :asc).includes(:countries).map do |item|
          {
            id: "region_#{item.code}",
            label: item.title.to_s,
            children: item.countries.order(code: :asc).map do |i|
              {
                id: "country_#{i.code}",
                label: i.title.to_s,
              }
            end
          }
        end
      end
    end

  end
end
