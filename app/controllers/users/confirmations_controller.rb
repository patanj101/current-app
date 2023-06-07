# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    # def new
    #   super
    #   authorize_confirmation
    # end

    # def create
    #   authorize_confirmation
    #   super
    # end

    # def show
    #   super
    #   authorize_confirmation
    # end

    protected

    def after_confirmation_path_for(_resource_name, resource)
      root_path
    end

    # def after_resending_confirmation_instructions_path_for(_resource_name)
    #   check_inbox_path
    # end

    # def authorize_confirmation = authorize(resource, policy_class: ConfirmationPolicy)
  end
end
