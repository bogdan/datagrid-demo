class DocumentReportsController < ApplicationController

  PER_PAGE = 10
  def index
    @document_report = DocumentReport.new(params[:document_report])
    @assets = @document_report.assets.page(params[:page])
  end
end
