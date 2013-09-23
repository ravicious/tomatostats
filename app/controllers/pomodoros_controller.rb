class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  expose(:pomodoros) { current_user.pomodoros.includes(:project).sorted_by_started_at }
  expose(:projects) { current_user.projects.sorted_by_name }

  def index

  end

  def delete_multiple_or_assign
    if params[:assign]
      assign
    elsif params[:delete_multiple]
      delete_multiple
    else
      redirect root_path
    end
  end

  private

  def delete_multiple
    pomodoros.delete(params[:pomodoros])

    flash[:notice] = "#{TextHelper.pluralize(params[:pomodoros].size, "pomodoro")} deleted."
    redirect_to root_path
  end

  def assign
    if project = projects.find_by_id(params[:project])
      pomodoros.where(id: params[:pomodoros]).update_all(project_id: project.id)
      flash[:notice] = "#{TextHelper.pluralize(params[:pomodoros].size, "pomodoro")} assigned."
    end
    redirect_to root_path
  end
end
