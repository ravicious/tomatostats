class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  expose(:projects) { current_user.projects }
  expose(:project, attributes: :project_params)

  def new

  end

  def create
    if project.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
