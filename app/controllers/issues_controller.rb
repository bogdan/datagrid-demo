class IssuesController < ApplicationController

  def index
    @grid = IssuesGrid.new(params.fetch(:g, {}).merge(page: params[:page]))
  end

end
