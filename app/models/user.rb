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
  has_many :projects, dependent: :destroy

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

  def to_s
    name
  end
end
