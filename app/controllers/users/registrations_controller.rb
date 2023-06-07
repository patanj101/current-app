# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: [:create]

    private

    def after_inactive_sign_up_path_for(_resource) = check_inbox_path

    # def after_update_path_for(_resource) = check_inbox_path
  end
end
