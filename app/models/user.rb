class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :validatable,
  # :database_authenticatable, :registerable,
  # :recoverable
  devise :rememberable, :trackable, :omniauthable,
         omniauth_providers: [:facebook]
  has_many :pomodoros
end
