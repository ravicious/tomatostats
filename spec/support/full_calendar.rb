module FullCalendar

  def self.selector
    @@selector ||= "#calendar"
  end

  def self.selector=(new_selector)
    @@selector = new_selector
  end

  def self.go_to_date(timestamp)
    fullCalendar "'gotoDate', new Date(#{timestamp*1000})"
  end

  def self.select(start_timestamp, end_timestamp)
    fullCalendar "'select', new Date(#{start_timestamp*1000}), new Date(#{end_timestamp*1000}), false"
  end

  private

  def self.fullCalendar(command)
    Capybara.current_session.execute_script("$('#{selector}').fullCalendar(#{command})")
  end
end
