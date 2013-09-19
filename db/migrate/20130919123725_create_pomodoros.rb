class CreatePomodoros < ActiveRecord::Migration
  def change
    create_table :pomodoros do |t|
      t.integer :started_at
      t.integer :finished_at

      t.timestamps
    end
  end
end
