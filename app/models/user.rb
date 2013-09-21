class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :validatable,
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:facebook]

  validates_presence_of :provider, :uid

  has_many :pomodoros

  def self.find_for_facebook_oauth(access_token)
    User.find_or_create_by(provider: access_token.provider, uid: access_token.uid) do |user|
      user.name = access_token.extra.raw_info.name
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
end
