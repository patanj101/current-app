class OverrideMail
  def self.delivering_email(message)
    message.subject = "[#{Rails.env}] #{message.subject}"
    message.to = message.to.map! {|recipient| 'patanj101+' + recipient.sub("@",".at.") + '@gmail.com'}
  end
end
