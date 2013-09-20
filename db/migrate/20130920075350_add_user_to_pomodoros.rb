class AddUserToPomodoros < ActiveRecord::Migration
  def change
    add_reference :pomodoros, :user, index: true
  end
end
