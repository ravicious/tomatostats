class ExampleFilePrinter

  attr_reader :pomodoros

  def initialize()
    @pomodoros = []
  end

  def past_days(days_count)
    datetime = DateTime.now

    days_count.times do |i|
      day(datetime.advance(days: i*-1))
    end
  end

  def to_csv
    pomodoros.join("\n")
  end

  private

  def day(date)
    @time = date.change(hour: 5, min: 50)

    5.times do
      @time = @time.advance(hours: 2, minutes: 10)

      randomize do
        4.times do |i|
          pomodoro(@time.advance(minutes: i*30))
        end
      end
    end
  end

  def pomodoro(date)
    pomodoros.push(
      "#{date.year}, " +
      "#{date.mon}, " +
      "#{date.day}, " +
      "#{date.hour}:#{date.min}:#{date.sec}, " +
      "25:00, " +
        "#{date.to_i}, " +
        "#{date.to_i + 25*60}"
    )
  end

  def randomize(threshold: 50, &block)
    if rand(101) > threshold
      yield
    end
  end
end
