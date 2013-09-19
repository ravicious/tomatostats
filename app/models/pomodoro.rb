class Pomodoro < ActiveRecord::Base

  def duration
    Time.diff Time.at(started_at), Time.at(finished_at)
  end
end
