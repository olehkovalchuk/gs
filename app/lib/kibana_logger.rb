class KibanaLogger
  def self.configure!
    @@logger = LogStashLogger.new(type: :udp, host: Rails.application.secrets[:logstash][:host], port: Rails.application.secrets[:logstash][:port], sync: true)
  end

  def self.push(event_name, **data)
    return false if Rails.env.development?
    log_data = (RequestStore.store[:kibana_data] || {}).merge(
      event_name: event_name,
    ).merge(data)
    @@logger.info( LogStash::Event.new(log_data) )
  end

  configure! unless Rails.env.development?

  # Journal::Backend::Filebeat.save(message: "wefwe")
end

