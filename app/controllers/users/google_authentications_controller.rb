# frozen_string_literal: true

module Users
  class GoogleAuthenticationsController < ApplicationController

    def create
      build_google_identity
      authenticate_with_google
      build_user_with_google
      attach_avatar_async
      persist_session
    end

    private

    def attach_avatar_async
      return if @user.avatar.attached?

      UserAvatarProcessorJob.perform_async(@user.id, @google_identity.avatar_url)
    end

    def authenticate_with_google
      @google_identity.email_verified?
    end

    def build_google_identity
      @google_identity = GoogleSignIn::Identity.new(id_token)
    end

    def build_user_with_google
      @user =  User.find_or_create_by(user_params) do |user|
        user.password = @google_identity.client_id
        user.confirmed_at = Time.now
      end
    end

    def google_identity_username
      @google_identity.email_address.split('@').first
    end

    def id_token = flash[:google_sign_in]["id_token"]

    def persist_session
      if sign_in(@user)
        redirect_to root_path
      else
        redirect_to new_user_session_path
      end
    end

    def user_params
      { email: @google_identity.email_address,google_user_id: @google_identity.user_id,
        username: google_identity_username }
    end
  end
end
