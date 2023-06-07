module SubscriberOperation

  class Base
    include Operation::Base
    crudify except: [:create], with:[:exel] do
      model_name Subscriber
    end
  end

  class Create < Base
    validate_with ::SubscriverValidation::Create
    def perform
      @model = ::Subscriber.find_or_initialize_by(email: form.email)
      ::KibanaLogger.push("subscribe", {email: form.email})
      @model.save!
      return true
    end
  end



end
