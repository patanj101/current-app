# frozen_string_literal: true

module Account
  class UserAvatarsController < AccountController

    def edit
      byebu
    end

    def update
      load_user
      build_avatar
      persist_user
    end

    def destroy
      load_user
      detach_avatar
      persist_user
    end

    private

    def build_avatar
      @user.assign_attributes(user_params)
    end

    def detach_avatar
      @user.avatar.detach
    end

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

    def render_user
      set_notice_message
      redirect_to edit_account_settings_path
    end

    def render_user_error
      set_alert_message(@user)
      render :edit, status: :unprocessable_entity
    end

    def save_user = @user.save

    def user_params
      params.require(:user).permit(:avatar)
    end

  end
end
