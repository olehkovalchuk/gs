module GeoLocation
  module_function
  def country_code( ip )
    return "UA" unless ip_object(ip)
    if location = @@geoip.country(ip)
      location.country_code2
    else
      "UA"
    end
  end

  def location(ip)
    return [0,0] unless city_ip_object(ip)
    if location = @@city_geoip.city(ip)
      [location.latitude,location.longitude]
    else
      [0,0]
    end
  end

  def ip_object( ip )
    return nil if ["127.0.0.1","0.0.0.0","172.22.0.1",'--'].include?( ip )
    @@geoip ||= GeoIP.new("#{Rails.root}/app/data/GeoIP.dat")
  end

  def city_ip_object( ip )
    return nil if ["127.0.0.1","0.0.0.0","172.22.0.1",'--'].include?( ip )
    @@city_geoip ||= GeoIP.new("#{Rails.root}/app/data/GeoLiteCity.dat")
  end

end
