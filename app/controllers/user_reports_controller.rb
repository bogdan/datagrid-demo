class UserReportsController < ApplicationController

  def index
    @user_report = UserReport.new(params[:user_report])
  end
end
