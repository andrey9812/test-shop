class CartController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, only: [:destroy]
  before_action :authenticate_user!

  def add
    product_cart.add(params)
    respond_to do |format|
      format.json {
        render json: {
          cart: product_cart.to_json,
          full_price: product_cart.formated_full_price,
          full_count: product_cart.full_count,
          text: Russian.p(product_cart.full_count, ' товар',' товара',' товаров'),
          status: 200
        }
      }
    end
  end

  def show
  end

  def update
    product_cart.update_count(params)
    respond_to do |format|
      format.json {
        render json: {
          cart: product_cart.to_json,
          full_price: product_cart.formated_full_price,
          full_count: product_cart.full_count,
          text: Russian.p(product_cart.full_count, ' товар',' товара',' товаров'),
          status: 200
        }
      }
    end
  end

  def destroy
    product_cart.delete(params)
    redirect_to :back
  end

  def full_price

  end

end
