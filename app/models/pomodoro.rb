class Pomodoro < ActiveRecord::Base
  validate :duration_cannot_be_longer_than_1_hour

  def duration
    Time.diff Time.at(started_at), Time.at(finished_at)
  end

  def duration_cannot_be_longer_than_1_hour
    if duration[:hour] > 1
      errors.add(:duration, "can't be longer than 1 hour")
    end
  end

end
