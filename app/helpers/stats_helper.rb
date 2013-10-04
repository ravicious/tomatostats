module StatsHelper
  def days_range(first_date, last_date)
    start_date = Date.parse(first_date).to_s(:short)
    end_date = Date.parse(last_date).to_s(:short)
    "#{start_date} - #{end_date}"
  end

  def pomodoros_count(count)
    content_tag(:span, class: 'pomodoros-count') do
      pluralize(count, "pomodoro")
    end
  end
end
