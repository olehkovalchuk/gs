
module Geo
  module PortAction
    extend self

    def before_save( model, form )
      model.region_code = model.country.region_code
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



