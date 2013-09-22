class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  expose(:pomodoros) { current_user.pomodoros }
  expose(:projects) { current_user.projects }

  def index

  end
end
