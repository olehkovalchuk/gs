
module Meat
  module TelegramUserOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name TelegramUser
      end
    end
  end
end

