module Meat
  module CategorySerializer
    class Main < ActiveModel::Serializer
      attributes :id,:title
    end
  end
end
