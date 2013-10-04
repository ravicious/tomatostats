module DateHelper
  def days_range(first_date, last_date)
    start_date = Date.parse(first_date).to_s(:short)
    end_date = Date.parse(last_date).to_s(:short)
    "#{start_date} - #{end_date}"
  end
end
