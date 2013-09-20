require 'singleton'

class Importer
  include Singleton

  Response = Struct.new(:success?, :pomodoros_added_count)
  FAIL_RESPONSE = Response.new(false, 0)

  def importers
    @@importers ||= Hash.new(EmptyImporter)
  end

  def response
    @@response ||= nil || FAIL_RESPONSE
  end

  def import(input, user)
    clear_response
    read_input(input)
    create_and_assign_pomodoros_to_user(user)
    self
  end

  private

  def clear_response
    @@response = nil
  end
end
