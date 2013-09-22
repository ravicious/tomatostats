class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  expose(:pomodoros) { current_user.pomodoros }
  expose(:projects) { current_user.projects }

  def index

  end

  def destroy_multiple
    current_user.pomodoros.delete(*params[:pomodoros])

    flash[:notice] = "#{TextHelper.pluralize(params[:pomodoros].size, "pomodoro")} deleted."
    redirect_to root_path
  end
end
