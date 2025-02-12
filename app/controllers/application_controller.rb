class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!


  private

  def store_user_location!
    store_location_for(:user, request.fullpath) if request.get? && !request.xhr?
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
end
