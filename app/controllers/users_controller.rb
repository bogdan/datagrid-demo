class UsersController < ApplicationController
  def index
    @users_grid = UsersGrid.new(params[:g]) do |scope|
      scope.page(params[:page])
    end
  end
end
