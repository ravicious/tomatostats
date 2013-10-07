require 'csv'

class ClockworkTomatoImporter < Importer

  def self.input(new_input)
    new_input = new_input.to_path if new_input.respond_to?(:to_path)
    @input = new_input.to_str
  end

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
