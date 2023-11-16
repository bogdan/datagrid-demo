class DocumentsController < ApplicationController

  def index
    @documents_grid = DocumentsGrid.new(params[:g]) do |scope|
      scope.page(params[:page])
      # scope.limit(25).offset(((params[:page] || 1) - 1) * 25 )
    end
  end
end
