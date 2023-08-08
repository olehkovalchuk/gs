class UserMailer < ApplicationMailer
  include ApplicationHelper
  def change_password( user, password )
    safe_action 'change_password', nil, false do |template|
      _placeholders( user ).merge(
        password: password
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      user.email
    end
  end

  def remind_password( user, template = 'remind_password' )
    safe_action template, nil, false do |template|
      _placeholders( user ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      user.email
    end
  end

  def inq_registration( user, template = 'inq_registration' )
    safe_action 'inq_registration', nil, false do |template|
      _placeholders( user ).merge(
        link: inq_restore_password_url(token: user.reset_password_token) 
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = I18n.t('common.emails.inq_registration')

      user.email
    end
  end

  def chat_message( user, model )
    url = user.reset_password_token.presence ? inq_restore_password_url(token: user.reset_password_token) : "https://globsupplies.com/marketplace/cabinet/conversations/#{model.conversation.id}"
    safe_action 'chat_message', nil, false do |template|
      _placeholders( user ).merge(
        sender: model.sender_company.title,
        message: model.text,
        chat_link: url
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = 'You have a new message on GlobalSupplies'

      user.email
    end
  end

  def new_bid( user, model )
    safe_action 'new_bid', nil, false do |template|
      _placeholders( user ).merge(
        sender: model.sender_company_title,
        product: model.bidable.category_title,
        chat_link: "https://globsupplies.com/marketplace/cabinet/bids"
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = 'You have a new Bid on Global Supplies'

      user.email
    end
  end

  def send_offers( user, model, title )
    safe_action 'send_offers', nil, false do |template|
      _placeholders( user ).merge(
        product: model.category_title,
        chat_link: "https://globsupplies.com/marketplace/cabinet/notifications"
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = title

      user.email
    end
  end

  def success_transaction( user, model )
    safe_action 'success_transaction', nil, false do |template|
      _placeholders( user ).merge(
        service: model.title,
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = 'Success payment on Global Supplies'

      user.email
    end
  end


  def failed_transaction( user, model )
    safe_action 'failed_transaction', nil, false do |template|
      _placeholders( user ).merge(
        service: model.title,
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = 'Failed payment on Global Supplies'

      user.email
    end
  end

  def registration( user, password, code )
    safe_action 'registration', nil, false do |template|
      _placeholders( user ).merge(
        password: password,
        verify_url: verify_url(code: code),
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      user.email
    end
  end


  def notify( user, subject, text, from = nil, email = nil )
    safe_action 'notification', from do |template|
      _placeholders( user ).merge(
        text: text.html_safe
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = subject
      (email || user.email)
    end
  end

  def inquiry( user, subject, _inquiry )
    headers({"INQUIRYID" => _inquiry.inquiry_email})
    safe_action 'inquiry', _inquiry.inquiry_email, false do |template|
      _placeholders( user ).merge(
        text: _inquiry.message.html_safe,
        product: _inquiry.inquirieable.category_title,
        from_name: _inquiry.title,
        link: "https://globsupplies.com/marketplace?inquiry_id=#{_inquiry.inquiry_email.split('@').first.split('+').last}#/#{_inquiry.inquirieable_type.demodulize.downcase}s/#{_inquiry.inquirieable_id}"
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = subject
      _inquiry.receiver_email
    end
  end

  def subscription( user, items )
    safe_action 'subscription' do |template|
      _placeholders( user ).merge(
        text: susbciptions(items).html_safe
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      template.title = subject
      user.email
    end
  end

  def verify( user, code )
    safe_action 'verify', nil, false do |template|
      _placeholders( user ).merge(
        verify_url: verify_url(code: code),
      ).each_pair{ |k,v| template.text = template.text.gsub!("%#{k.to_s.upcase}%",v.to_s) }
      user.email
    end
  end

  private

  def _placeholders( user )
    plc = {
      email: user.email,
      username: "#{user.last_name} #{user.first_name}",
      root_url: root_url,
      app_name: "Global Supplies",
      copyright: "Global Supplies #{Date.today.year}"
    }
    plc[:expire_at] = I18n.l( user.reset_password_expire_at, format: :short ) if user.reset_password_expire_at.presence
    plc[:link] = restore_url(token: user.reset_password_token) if user.reset_password_token.presence
    plc
  end

end
