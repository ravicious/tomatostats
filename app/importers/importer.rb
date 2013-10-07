class Importer

  attr_reader :imported_pomodoros
  attr_accessor :input

  def initialize(args = {})
    self.input = args[:input]
    @user = args[:user]
    @imported_pomodoros = []
  end

  # TODO: refactor this to be valid
  # with open/closed principle
  def self.importers
    Hash.new(EmptyImporter).tap do |hash|
      hash['Clockwork Tomato'] = ClockworkTomatoImporter
    end
  end

  def import
    custom_import
  end

  private

  def create_and_assign_pomodoro(args = {})
    pomodoro = @user.pomodoros.find_or_initialize_by(args)
    if pomodoro.new_record?
      @imported_pomodoros.push(pomodoro) if pomodoro.save
    end
  end

end
