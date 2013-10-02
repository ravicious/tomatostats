require 'csv'

class ClockworkTomatoImporter < Importer

  private

  def custom_import
    lines = []

    IO.foreach(@input) do |line|
      lines << line
      if lines.size >= 100
        parse_lines(lines)
        lines = []
      end
    end

    parse_lines(lines)
  end

  def parse_lines(lines)
    begin
      CSV.parse(lines.join) do |row|
        create_and_assign_pomodoro(started_at: row[5], finished_at: row[6])
      end
    rescue TypeError, ArgumentError, CSV::MalformedCSVError
      nil
    end
  end

end
