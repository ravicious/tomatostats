require 'singleton'

class Importer
  include Singleton

  attr_writer :response

  Response = Struct.new(:success?, :pomodoros_added_count)
  @empty_response = Response.new(false, 0)

  def importers
    @importers ||= Hash.new(EmptyImporter)
  end

  def response
    @response || @empty_response
  end

  def import(input, user)
    read_input(input)
    create_and_assign_pomodoros_to_user(user)
    self
  end
end
