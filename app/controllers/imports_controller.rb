class ImportsController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    file = params[:import][:file].path
    @import = Importer.importers[params[:import][:application]].new(input: file, user: current_user)
    @import.import
    redirect_to root_path
  end
end
