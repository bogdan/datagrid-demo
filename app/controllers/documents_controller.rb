class DocumentsController < ApplicationController

  def index
    @documents_grid = DocumentsGrid.new(params[:documents_grid]) do |scope|
      scope.page(params[:page])
    end
  end
end
