class ProjectsController < ApplicationController
  before_filter :authenticate_user!

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
    if project.save
      flash[:success] = "Project #{project} updated."
      redirect_to project
    else
      render :edit
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
