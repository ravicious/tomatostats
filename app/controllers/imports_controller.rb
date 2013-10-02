class ImportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :initialize_importer, only: :create

  def new
  end

  def create
    @importer.import

    if @importer.imported_pomodoros.size > 0
      flash[:success] = "#{TextHelper.pluralize(@importer.imported_pomodoros.size, "pomodoro")} imported."
    else
      flash[:notice] = "Zero new pomodoros imported."
    end

    redirect_to root_path
  end

  private

  def initialize_importer
    file = params[:import][:file].path
    @importer = Importer.importers[params[:import][:application]].new(input: file, user: current_user)
  end
end
