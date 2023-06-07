module Order
  class ServicePresenter < BasePresenter

    def documents
      @documents ||= Meat::Document.where(id: @object.documents )
    end

    def by_period?
      ["per_month","per_day","per_year"].include?(@object.usage_type)
    end

    def usage_period
      return 0 unless by_period?
      @object.usage_period.to_i.send(@object.usage_type.sub("per_",''))
    end
  end
end
