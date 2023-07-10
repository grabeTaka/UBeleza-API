class ApplicationController < ActionController::API

  private
  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id]) if doorkeeper_token
    @current_user
  end
end
