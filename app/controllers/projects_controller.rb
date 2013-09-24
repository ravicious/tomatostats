class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html

  expose(:projects) { current_user.projects.sorted_by_name.includes(:pomodoros) }
  expose(:project, attributes: :project_params)

  def create
    if project.save
      flash[:success] = "Project #{project} added."
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    flash[:success] = "Project #{project} updated." if project.save
    respond_with project
  end

  def destroy
    flash[:success] = "Project #{project} deleted." if project.destroy
    respond_with project
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
