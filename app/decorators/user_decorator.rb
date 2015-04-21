class UserDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  delegate_all
  decorates_finders

  def display_credit_full
    unless source.credit.nil?
      "На счету: " + number_to_currency(source.credit).to_s
    end
  end

  def display_credit
    if source.credit.blank?
      number_to_currency(source.credit)
    end
  end
end