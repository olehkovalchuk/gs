module FrontLogger
  # Parametrize before writing to store
  # @param args [Hash] set of params to write to log
  def self.parametrize(args)
    request = RequestStore.store[:request]
    args[:core_ip] = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}.try(:ip_address)
    args[:request_id] = RequestStore.store[:request_id]
    args[:request_type] = :front
    args[:user_agent] = request.try(:user_agent)
    args[:http_method] = "#{request.method_symbol}".upcase
    args[:http_format] = "#{request.format.symbol}".upcase
    if RequestStore.store[:current_user]
      args[:user_type] = 1
      args[:user_id] = RequestStore.store[:current_user].id
      args[:user_login] = RequestStore.store[:current_user].email
      
      args[:user_token] = RequestStore.store[:user_token]
    end
    args[:user_ip] = request.try(:remote_ip)
    if args[:user_ip]
      args[:client_ip] = args[:user_ip]
      args[:user_country] =  args[:client_country] = GeoLocation.country_code(args[:user_ip])
    end

    params = request.params

    

    args[:component] = params[:controller] unless args[:component]
    args[:activity] = params[:action] unless args[:activity]
    args[:args] = params.reject{|k, v| "#{k}" =~ /_base64_data/ || "#{k}" =~ /fields/ || "#{k}" =~ /files/} unless args[:args]

    unless args[:file]
      args[:file] = RequestStore.store[:response_body]
      if args[:file]
        args[:file_type] = 'raw'
        if args[:file].respond_to?(:to_json)
          args[:file] = args[:file].to_json
          args[:file_type] = 'json'
        end
        args[:file_description] = 'Response'
      end
    end      
    args
  end
end