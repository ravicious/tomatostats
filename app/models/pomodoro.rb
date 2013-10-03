class Pomodoro < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validate :duration_cannot_be_longer_than_1_hour
  validates_uniqueness_of :started_at, :finished_at, scope: :user
  validates_numericality_of :started_at, :finished_at

  # TODO: rewrite this method
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

  # TODO: clean this up
  def self.stats
    in_month = group("to_char(to_timestamp(started_at), 'YYYY-MM')").count.sort
    in_week = group("to_char(to_timestamp(started_at), 'YYYY-MM-WW')").count.sort
    in_day = group("to_char(to_timestamp(started_at), 'YYYY-MM-WW-DD')").count.sort

    stats = {}
    stats['count'] = in_month.flatten.reject {|obj| !obj.is_a?(Integer)}.sum
    stats['months'] = {}

    in_month.each do |key, value|
      stats['months'][key] = { 'weeks' => {}, 'count' => value }
    end

    in_week.each do |key, value|
      month = key.match(/[0-9]{4}-[0-9]{2}/).to_s

      stats['months'][month]['weeks'][key] = { 'days' => {}, 'count' => value }
    end

    in_day.each do |key, value|
      month = key.match(/[0-9]{4}-[0-9]{2}/).to_s
      week = key.match(/[0-9]{4}-[0-9]{2}-[0-9]{1,2}/).to_s
      day = key.match(/[0-9]{2}$/).to_s

      stats['months'][month]['weeks'][week]['days']["#{month}-#{day}"] = { 'count' => value }
    end

    stats
  end

  def self.done_weeks_ago(number_of)
    self.done_some_time_ago(number_of, 'week')
  end

  def self.done_months_ago(number_of)
    self.done_some_time_ago(number_of, 'month')
  end

  def self.done_this_week
    self.done_weeks_ago(0)
  end

  def self.done_this_month
    self.done_months_ago(0)
  end

  def has_project?
    project_id
  end

  private

  def self.done_some_time_ago(number_of, time_range_type)
    beginning_of_time_range_in_seconds = eval("#{number_of}.#{time_range_type}s.ago.to_date." +
                                              "at_beginning_of_#{time_range_type}.to_time.to_i")
    where("started_at >= ?", beginning_of_time_range_in_seconds)
  end

end
