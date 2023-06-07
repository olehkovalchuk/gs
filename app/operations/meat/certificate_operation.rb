
module Meat
  module CertificateOperation
    class Base 
      include Operation::Base
      crudify do 
        model_name Certificate
      end
    end
  end
end

