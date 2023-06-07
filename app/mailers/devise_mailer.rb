# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  # default template_path: 'devise/mailer'

  def deactivation_instructions(record, token, _opts = {})
    @token = token
    devise_mail(record, :deactivation_instructions)
  end
end
