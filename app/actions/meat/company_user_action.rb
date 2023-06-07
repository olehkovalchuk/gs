
module Meat
  module CompanyUserAction
    extend self

    def before_save( model, form )
      model.company_id = Meat::CompanyOperation::Create.new(user: model).run.id unless model.company_id
    end

    def after_create( model, form )
      model.company.increment!(:managers_count)
    end
    def after_destroy( model )
      model.company.decrement!(:managers_count)
    end

    def assign_package( model, form )
      if package = Order::Package.find_by(default: true)
        %w[offers_count requests_count received_inquries replyies_to_inquries active_chats show_infos buyer_allerts sended_inquries top_offers].each do |field|
          model.company.update( "#{field}_limit" => (model.company.send("#{field}_limit") - model.company.send("#{field}_used")) + package.send(field).to_i )
          model.company.update( "#{field}_used" => 0)
        end
        model.company.update(sub_accounts_limit: package.sub_accounts )
        model.company.update(rating_code: package.rating_code )
        model.company.update(on_map: package.map_access )
        package_expiration = model.company.package_expiration < Date.current ? Date.current : model.company.package_expiration
        model.company.update(package_expiration: (package_expiration + package.days) )
      end
    end

    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



