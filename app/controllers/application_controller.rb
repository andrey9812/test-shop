class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location

  helper_method :back_path, :product_cart, :decorated_current_user

protected

  def store_location
    session[:return_to] = request.original_url if request.get? && request.format == :html

    true
  end

  def back_path
    session[:return_to]
  end

  def product_cart
    @product_cart = ProductCart.new(cookies)
  end

  def decorated_current_user
    @decorated_current_user ||= current_user.try(:decorate)
  end

end
