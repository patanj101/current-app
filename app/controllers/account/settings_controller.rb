# frozen_string_literal: true

module Account
  class SettingsController < AccountController

    def edit
      load_user
    end

    def update
      load_user
      build_user
      persist_user
    end

    private

    def load_user
      @user = current_user
    end

    def persist_user
      if save_user
        render_user
      else
        render_user_error
      end
    end

    def build_user
      @user.assign_attributes(user_enhanced_params)
    end

    def render_user
      set_notice_message
      redirect_to check_inbox_path
    end

    def render_user_error
      set_alert_message(@user)
      render :edit, status: :unprocessable_entity
    end

    def save_user = @user.save

    def user_params
      params.require(:user).permit(:username)
    end

    def user_enhanced_params
      user_params
    end

  end
end
