class TimeEntriesController < ApplicationController

  def index
    @time_entries_grid = TimeEntriesGrid.new(params[:g]) do |scope|
      scope.page(params[:page] )
    end
  end
end
