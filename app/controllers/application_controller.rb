class ApplicationController < ActionController::Base
  include Authentication

  helper_method :current_user

  def current_user
    Current.session&.user
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
