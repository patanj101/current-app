# frozen_string_literal: true

class UserAvatarProcessor < ApplicationService
  require 'open-uri'

  def initialize(user, avatar_url)
    @user = user
    @avatar = URI.open(avatar_url)
  end

  def call
    return false unless processable

    process
  end

  private

  def processable
    @user && @avatar
  end

  def process
    attach_avatar
    persist_avatar
  end

  def attach_avatar
    @user.avatar.attach(io: @avatar, filename: avatar_filename )
  end

  def avatar_filename
    @user.username + "-avatar-" + Time.now.strftime("%Y%m%d%H%M%S")
  end

  def persist_avatar
    @user.avatar.save
  end
end
