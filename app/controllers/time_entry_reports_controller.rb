class TimeEntryReportsController < ApplicationController

  def index
    @time_entry_report = TimeEntryReport.new(params[:time_entry_report])
    @assets = @time_entry_report.assets.page(params[:page])
  end
end
