class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  protected

  def send_mail( template, to_email, attachments = {}, from_email = false )

    from_email = from_email ? from_email : Rails.application.secrets.fetch(:smtp,{}).fetch(:from, 'info@globsupplies.com')

    mail_options = {
      to: to_email,
      subject: template.title,
      from: from_email,
      reply_to: from_email,
      message_id: "<#{SecureRandom.uuid}@#{from_email.split('@').last}>",
      parts_order: [ "text/html", "application/octet-stream" ]
    }

    attachments.each{ |k,v| self.attachments[k] = v } if attachments.kind_of? Hash
    mail(mail_options) do |format|
      format.html {render html: template.text.html_safe}
    end
  end

  def safe_action( code, from = nil, with_layout = true, &block )
    begin
      operation = ::Content::EmailTemplateOperation::Find.new( code: code, with_layout: with_layout )
      fail Operation::Error.new( operation.errors ) unless template = operation.process
      template = template.dup
      email, attachmets = *yield(template)
      # email = "eurocommercemd@gmail.com"
      Journal.success( log_code: :front_mail, args: {emails: email}, session_id: code, description: template.title , file:{content: template.text ,type:"raw"} )
      send_mail template, Array.wrap(email).join(","), attachmets, from
    rescue => e
      Journal.exception( log_code: :mail, args: {emails: email}, session_id: code, description: e.message , file:{content: e.backtrace.join("\n"),type:"raw"} )
    end
  end

end

