class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  # :database_authenticatable, :registerable
  # :recoverable, :validatable
  devise :rememberable, :trackable
  has_many :pomodoros
end
