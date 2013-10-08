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

  def validate
    validate_file_size
  end

  def validate_file_size
    if input.size > 512.kilobytes
      errors.push "File size is too big (should be less than 512 kilobytes)"
    end
  end

end
