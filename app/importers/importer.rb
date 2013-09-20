class Importer

  Response = Struct.new(:success?, :pomodoros_added_count)
  FAIL_RESPONSE = Response.new(false, 0)

  def initialize(input, user)
    @input = input
    @user = user
    @response = nil
  end

  def importers
    @@importers ||= Hash.new(EmptyImporter)
  end

  def response
    @response || FAIL_RESPONSE
  end

  def import
    begin
      count_imported_pomodoros do
        custom_import
      end
      set_success_response
    rescue
      set_fail_response
    ensure
      self
    end
  end

  private

  def create_and_assign_pomodoro(args = {})
    @user.pomodoros.find_or_create_by(args)
  end

  def count_imported_pomodoros(&block)
    pomodoros_before = @user.pomodoros.count
    yield
    @pomodoros_count = @user.pomodoros.count - pomodoros_before
  end

  def set_success_response
    @response = Response.new(true, @pomodoros_count)
  end

  def set_fail_response
    @response = Response.new(false, 0)
  end
end
