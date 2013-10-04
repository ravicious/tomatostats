module StatsProcessor
  class Stats
    attr_accessor :months

    def initialize(raw_months, raw_weeks, raw_days)
      @raw_months = raw_months
      @raw_weeks = raw_weeks
      @raw_days = raw_days
      @months = []
    end

    def parse
      parse_months
      parse_weeks
      parse_days
      self
    end

    def count
      months.sum(&:count)
    end

    private

    def parse_months
      @raw_months.each do |month_date, month_count|
        @months.push Month.new(month_date, month_count)
      end
    end

    # '2013-04-1'.include? '2013-04'
    def find_month(date)
      @months.find {|month| date.include?(month.date) }
    end

    def parse_weeks
      @raw_weeks.each do |week_date, week_count|
        find_month(week_date).weeks.push Week.new(week_date, week_count)
      end
    end

    def parse_days
      @raw_days.each do |day_date, day_count|
        find_month(day_date).find_week(day_date).days.push Day.new(day_date, day_count)
      end
    end

  end

  class DateUnit
    attr_accessor :date, :count

    def initialize(date, count)
      self.date = date
      self.count = count
    end
  end

  class Month < DateUnit
    attr_accessor :weeks

    def initialize(date, count)
      super
      @weeks = []
    end

    def find_week(date)
      @weeks.find {|week| date.include?(week.date) }
    end
  end

  class Week < DateUnit
    attr_accessor :days

    def initialize(date, count)
      super
      @days = []
    end
  end

  class Day < DateUnit
    def date=(new_date)
      new_date = new_date.split('-')
      new_date.delete_at(2)
      @date = new_date.join('-')
    end
  end
end
