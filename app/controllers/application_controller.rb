class ApplicationController < ActionController::Base

  private

  def set_notice_message
    flash.notice = t('.success')
  end

  def set_alert_message(resource)
    return unless resource.errors.any?

    flash.now.alert = error_in_full(resource)
  end

  def error_in_full(resource)
    resource.errors.full_messages.map { |msg| msg }.join(". ")
  end
end
