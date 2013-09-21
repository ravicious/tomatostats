class ImportsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    file = params[:import][:file].path
    @import = Importer.importers[params[:import][:application]].new(input: file, user: current_user)
    @import.import
    if @import.imported_pomodoros > 0
      flash[:notice] = "#{TextHelper.pluralize(@import.imported_pomodoros, "pomodoro")} imported."
    else
      flash[:notice] = "Zero new pomodoros imported."
    end
    redirect_to root_path
  end
end
