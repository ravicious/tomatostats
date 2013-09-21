class ImportsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    file = params[:import][:file].path
    @importer = Importer.importers[params[:import][:application]].new(input: file, user: current_user)
    @importer.import
    if @importer.imported_pomodoros.size > 0
      flash[:notice] = "#{TextHelper.pluralize(@importer.imported_pomodoros.size, "pomodoro")} imported."
    else
      flash[:notice] = "Zero new pomodoros imported."
    end
    redirect_to root_path
  end
end
