class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :validatable,
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:facebook]
  has_many :pomodoros

  def self.find_for_facebook_oauth(access_token)
    User.find_or_create_by(provider: access_token.provider, uid: access_token.uid) do |user|
      user.name = access_token.extra.raw_info.name
    end
  end
end
