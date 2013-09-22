class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  expose(:projects) { current_user.projects }
  expose(:project)

  def new

  end
end
