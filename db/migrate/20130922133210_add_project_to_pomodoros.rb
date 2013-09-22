class AddProjectToPomodoros < ActiveRecord::Migration
  def change
    add_reference :pomodoros, :project, index: true
  end
end
