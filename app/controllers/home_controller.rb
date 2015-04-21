class HomeController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  helper_method :products_collection, :decorated_products_collection

  def show
  end

protected

  def products_collection
    @products_collection ||= Product.random.limit(9)
  end

  def decorated_products_collection
    @decorated_products_collection ||= products_collection.includes(:cover).decorate
  end
end
