class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  expose(:pomodoros) { current_user.pomodoros }

  def index

  end
end
