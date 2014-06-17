class TimeEntryReportsController < ApplicationController

  def index
    @time_entry_report = TimeEntryReport.new(params[:time_entry_report]) do |scope|
      scope.page(params[:page])
    end
  end
end
