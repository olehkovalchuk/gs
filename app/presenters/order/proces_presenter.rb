module Order
  class ProcesPresenter < BasePresenter

    def documents
      @documents ||= Meat::Document.where(id: @object.documents )
    end

    def kibana_data
      {}
    end
  end
end
