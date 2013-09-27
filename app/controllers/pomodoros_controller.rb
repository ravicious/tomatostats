class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  expose(:pomodoros) { current_user.pomodoros }
  expose(:projects) { current_user.projects.sorted_by_name }
  respond_to :html, :json

  def index
    respond_to do |format|
      format.html { self.pomodoros = pomodoros.for_html }
      format.json {
        self.pomodoros = pomodoros.for_json.time_filtered(
          started: params[:start].presence || 0,
          finished: params[:end].presence || Time.current.to_i
        )
        render json: pomodoros
      }
    end
  end

  def delete_multiple_or_assign
    @pomodoros_array = params[:pomodoros]

    if params[:assign]
      assign
    elsif params[:delete_multiple]
      delete_multiple
    end

    redirect_to root_path
  end

  private

  def delete_multiple
    pomodoros.delete(@pomodoros_array)
    flash[:success] = "#{TextHelper.pluralize(@pomodoros_array.size, "pomodoro")} deleted."
  end

  def assign
    if project = projects.find_by_id(params[:project])
      pomodoros.where(id: @pomodoros_array).update_all(project_id: project.id)
      flash[:success] = "#{TextHelper.pluralize(@pomodoros_array.size, "pomodoro")} assigned."
    end
  end

  def pomodoros_for_json
  end
end
