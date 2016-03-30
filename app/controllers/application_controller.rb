class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_heroku_legacy_route

  def redirect_heroku_legacy_route
    if request.host =~ /heroku.com$/
      redirect_to request.url.gsub('heroku.com', 'herokuapp.com'), status: 301
    end
  end
end
