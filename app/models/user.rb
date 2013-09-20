class User < ActiveRecord::Base
  has_many :pomodoros
end
