class InvoiceDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all
  decorates_finders

  def formated_date
    source.created_at.strftime('%H:%M %d-%m-%Y')
  end

  def display_products
    html = ''
    products = Product.where(id: source.product_cart.keys)
    h.content_tag(:ul, style: '') do
      products.each do |product|
        html << h.content_tag(:li) { "#{product.title} - #{source.product_cart[product.id.to_s]}шт" }
      end
    end
    html.html_safe
  end

  def full_sum
    number_to_currency(source.cost)
  end

end