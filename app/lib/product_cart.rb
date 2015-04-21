class ProductCart
  include ActionView::Helpers::NumberHelper

  def initialize(cookie)
    @cookie = cookie
  end

  def add(params)
    if @cookie[:cart].present?
      cart = JSON.parse(@cookie[:cart])
    else
      cart = {}
    end
    if cart[params[:id]].blank?
      cart[params[:id]] = params[:count]
    else
      cart[params[:id]] = cart[params[:id]].to_i + params[:count].to_i
    end
    @cookie[:cart] = JSON.generate(cart)
  end

  def update_count(params)
    return false if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    return false if cart[params[:id]].blank?
    if params[:count].to_i == 0
      cart.delete(params[:id])
    else
      cart[params[:id]] = params[:count]
    end
    @cookie[:cart] = JSON.generate(cart)
  end

  def delete(params)
    return false if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    return false if cart[params[:id]].blank?
    cart.delete(params[:id])
    @cookie[:cart] = JSON.generate(cart)
  end

  def full_price
    return 0 if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    products = Product.where(id: cart.keys)
    sum = 0
    products.each { |p| sum += (p.price * cart[p.id.to_s].to_i) }
    sum.round(2)
  end

  def formated_full_price
    return 0 if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    products = Product.where(id: cart.keys)
    sum = 0
    products.each { |p| sum += (p.price * cart[p.id.to_s].to_i) }
    number_to_currency sum.round(2)
  end

  def full_count
    return 0 if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    count = 0
    cart.each { |key, value| count += value.to_i }
    count
  end

  def clear
    @cookie[:cart] = nil
  end

  def empty?
    return true if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    cart.size == 0
  end

  def product_ids
    return [] if @cookie[:cart].blank?
    cart = JSON.parse(@cookie[:cart])
    cart.keys
  end

  def to_invoice
    return {} if @cookie[:cart].blank?
    { product_ids: product_ids, cost: full_price, product_cart: to_hash }
  end

  def to_hash
    return {} if @cookie[:cart].blank?
    JSON.parse(@cookie[:cart])
  end

  def to_json
    cart = JSON.parse(@cookie[:cart])
    products = Product.where(id: cart.keys).includes(:cover).decorate
    products.map do |p|
      [p.main_image_path, number_to_currency(p.price * cart[p.id.to_s].to_i), p.title, p.description, number_to_currency(p.price), cart[p.id.to_s].to_i, p.id]
    end
  end
end