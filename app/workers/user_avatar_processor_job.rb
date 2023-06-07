# frozen_string_literal: true

class UserAvatarProcessorJob
  include Sidekiq::Job
  sidekiq_options queue: 'low'

  def perform(user_id, avatar_url)
    user = User.find_by(id: user_id)
    UserAvatarProcessor.call(user, avatar_url)
  end
end
