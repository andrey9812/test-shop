class InvoicesController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :invoices_collection, :decorated_invoices_collection

  def index
  end

  def create
    if product_cart.full_price > current_user.credit
      redirect_to root_path, notice: 'Недостаточно средств, пополните счет.'
    else
      invoice = Invoice.create!(product_cart.to_invoice.merge(user: current_user, email: current_user.email))
      product_cart.clear
      redirect_to root_path
    end
  end

protected

  def decorated_invoices_collection
    @decorated_invoices_collection ||= invoices_collection.decorate
  end
  
  def invoices_collection
    @invoices_collection ||= Invoice.paid.by_date
  end
end
