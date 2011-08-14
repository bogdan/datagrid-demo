class TimeEntryReportsController < ApplicationController

  def index
    @time_entry_report = TimeEntryReport.new(params[:time_entry_report])
  end
end
