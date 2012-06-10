class GridsController < ApplicationController

  def index
    @grid = Grid.new
    @grids = Grid.all
  end

  def show
    @grid = Grid.find(params[:id])
  end

  def create
    @grids = Grid.all
    @grid = Grid.new(params[:grid])
  
    if @grid.save
      flash[:notice] = 'Grid was successfully created.'
      redirect_to grids_path
    else
      render :action => "index" 
    end
  end
end
