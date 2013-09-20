class Pomodoro < ActiveRecord::Base
  belongs_to :user
  validate :duration_cannot_be_longer_than_1_hour
  validates_uniqueness_of :started_at, :finished_at
  validates_numericality_of :started_at, :finished_at

  def duration
    Time.diff Time.at(started_at), Time.at(finished_at)
  end

  def duration_cannot_be_longer_than_1_hour
    if duration[:hour] > 1
      errors.add(:duration, "can't be longer than 1 hour")
    end
  end

end
