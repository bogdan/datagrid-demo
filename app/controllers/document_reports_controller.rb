class DocumentReportsController < ApplicationController

  def index
    @document_report = DocumentReport.new(params[:document_report]) do |scope|
      scope.page(params[:page])
    end
  end
end
