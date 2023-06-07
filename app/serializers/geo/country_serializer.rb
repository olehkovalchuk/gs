module Geo
  class CountrySerializer
    class Short < ActiveModel::Serializer
      attributes :code,:title

    end
  end
end
