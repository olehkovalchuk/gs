module WhatsappSender
  extend self

  TOKEN = '61d5b24af58fa79bba3fa862c98ba24117dd81b9'
  URL = 'https://pickyassist.com/app/api/v2/push'
  PERSONAl = 1
  BUSINESS = 2
  WEB = 10

  def status
    response = RestClient.post(
      'http://pickyassist.com/app/api/v1/device-status',
      { token:  TOKEN}.to_json,
      {content_type: :json, accept: :json}
    )
    Rails.logger.info response.body.inspect
  end

  def message(phone, text)
    {
      token: TOKEN,
      application: WEB,
      globalmessage: text,
      data: [
        {
          number: phone,
          message: text
        }
      ]
    }
  end

  def call(text, phone)
    puts message(phone, text).to_json,
    response = RestClient.post(
      URL,
      message(phone, text).to_json,
      {content_type: :json, accept: :json}
    )
    Rails.logger.info response.body.inspect
  end
end
