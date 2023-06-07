class User < ApplicationRecord

  ####
  #### _devise
  ####

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  ####
  #### associations
  ####

  has_one_attached :avatar

  ####
  #### attributes
  ####

  attribute :username, default: -> { "usr-" + rand(36**8).to_s(36) }

  ####
  #### callbacks
  ####

  ####
  #### constants
  ####

  ####
  #### extensions
  ####

  ####
  #### scopes
  ####

  ####
  #### validations
  ####

  validates :username, length: { minimum: 5 }, allow_blank: false

  ####
  ####
  ####

  private

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end
