class ApplicationController < ActionController::Base


  def info_not_found
    render json: {}, :status => 404
  end
end
