class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :validatable,
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :rememberable, :trackable, :omniauthable,
    omniauth_providers: [:facebook, :google_oauth2]

  validates_presence_of :provider, :uid

  has_many :pomodoros, dependent: :destroy

  def self.find_for_facebook_oauth(access_token)
    User.find_or_create_by(provider: 'facebook', uid: access_token.uid) do |user|
      user.name = access_token.extra.raw_info.name
    end
  end

  def self.find_for_google_oauth(access_token)
    User.find_or_create_by(provider: 'google_oauth2', uid: access_token.uid) do |user|
      user.name = access_token.info.name
    end
  end

  def avatar_url(height=180)
    send("#{provider}_avatar_url", height)
  end

  def to_s
    name
  end

  private

  def facebook_avatar_url(height)
    "http://graph.facebook.com/#{uid}/picture?type=square&height=#{height}"
  end

  def google_oauth2_avatar_url(height)
    "https://profiles.google.com/s2/photos/profile/#{uid}?sz=#{height}"
  end
end
