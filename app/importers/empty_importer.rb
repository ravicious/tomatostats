require 'singleton'

class EmptyImporter < Importer
  include Singleton

  private

  def read_input(input); end
  def create_and_assign_pomodoros_to_user(user); end
end
