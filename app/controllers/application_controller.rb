class ApplicationController < ActionController::Base


  def info_not_found
    render :status => 404
  end
end
