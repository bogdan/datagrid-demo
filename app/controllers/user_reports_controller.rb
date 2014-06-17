class UserReportsController < ApplicationController

  def index
    @user_report = UserReport.new(params[:user_report]) do |scope|
      scope.page(params[:page])
    end
  end
end
