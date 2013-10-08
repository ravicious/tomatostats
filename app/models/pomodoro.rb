class Pomodoro < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validate :duration_cannot_be_longer_than_1_hour
  validates_uniqueness_of :started_at, :finished_at, scope: :user
  validates_numericality_of :started_at, :finished_at

  def duration
    Time.diff Time.at(started_at), Time.at(finished_at), '%N %S'
  end

  def duration_cannot_be_longer_than_1_hour
    if duration[:hour] > 1
      errors.add(:duration, "can't be longer than 1 hour")
    end
  end

  def self.time_filtered(args = {})
    # nullify args
    # this is useful when there are empty params
    # passed from a controller
    args.each do |key, value|
      args[key] = nil if value.blank?
    end

    where("started_at >= ? and finished_at <= ?",
          args[:started], args[:finished])
  end

  def self.for_json
    joins(
      "LEFT OUTER JOIN projects ON projects.id = pomodoros.project_id"
    ).select(
      "pomodoros.id, pomodoros.started_at, pomodoros.finished_at, projects.name as project_name"
    )
  end

  def self.stats
    raw_months = group("to_char(to_timestamp(started_at), 'YYYY-MM')").count.sort
    raw_weeks = group("to_char(to_timestamp(started_at), 'YYYY-MM-IW')").count.sort
    raw_days = group("to_char(to_timestamp(started_at), 'YYYY-MM-IW-DD')").count.sort

    stats = StatsProcessor::Stats.new(raw_months, raw_weeks, raw_days).parse
  end

end
