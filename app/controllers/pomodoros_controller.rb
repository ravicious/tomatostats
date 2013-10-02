class PomodorosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_multiple_pomodoros, only: [:delete_multiple, :assign]
  respond_to :html, :json

  expose(:pomodoros) { current_user.pomodoros }
  expose(:projects) { current_user.projects.sorted_by_name }

  def index
    respond_to do |format|
      format.html
      format.json {
        self.pomodoros = pomodoros.for_json.time_filtered(
          started: params[:start],
          finished: params[:end]
        )
        render json: pomodoros
      }
    end
  end

  def delete_multiple
    pomodoros.delete_all
    respond_with_success_to_formats("#{TextHelper.pluralize(@pomodoros_size, "pomodoro")} deleted.")
  end

  def assign
    if project = projects.find_by_id(params[:project])
      pomodoros.update_all(project_id: project.id)

      respond_with_success_to_formats(
        "#{TextHelper.pluralize(@pomodoros_size, "pomodoro")} assigned."
      )
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { message: "Project not found." }, status: 400 }
      end
    end
  end

  private

  def respond_with_success_to_formats(message)
    respond_to do |format|
      format.html {
        flash[:success] = message
        redirect_to root_path
      }
      format.json {
        render json: { status: :ok, message: message }
      }
    end
  end

  def find_multiple_pomodoros
    self.pomodoros = pomodoros.time_filtered(
      started: params[:start],
      finished: params[:end]
    )

    @pomodoros_size = pomodoros.size
  end
end
