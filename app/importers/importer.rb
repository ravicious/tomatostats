class Importer

  attr_reader :imported_pomodoros

  def initialize(args = {})
    @input = args[:input]
    @user = args[:user]
    @imported_pomodoros = 0
  end

  def importers
    @@importers ||= Hash.new(EmptyImporter)
  end

  def import
    count_imported_pomodoros do
      custom_import
    end
  end

  private

  def create_and_assign_pomodoro(args = {})
    @user.pomodoros.find_or_create_by(args)
  end

  def count_imported_pomodoros(&block)
    pomodoros_before = @user.pomodoros.count
    yield
    @imported_pomodoros = @user.pomodoros.count - pomodoros_before
  end

end
