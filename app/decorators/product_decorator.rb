class ProductDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all
  decorates_finders

  def main_image_path
    (source.cover || source.images.first).try(:asset).try(:thumb).try(:url)
  end

  def price
    (product.price.blank? || product.count < 1) ? 'Нет в наличии' : number_to_currency(product.price)
  end

  def display_buy_button
    if source.count > 0 && price.present?
      h.content_tag(:div, class: "dropdown moderation_state") do
        html = ''
        html << h.link_to('Купить', 'javascript:void(0)', class: 'btn', role: 'addToCart', data: { id: product.id, count: 1 })
        html.html_safe
      end
    end
  end
end