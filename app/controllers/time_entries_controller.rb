class TimeEntriesController < ApplicationController

  def index
    @time_entries_grid = TimeEntriesGrid.new(params[:time_entries_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
