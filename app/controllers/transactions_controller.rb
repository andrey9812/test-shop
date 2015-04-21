class TransactionsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create
    Transaction.create!(target: current_user, user: current_user, type: 'inner', value: 1000).try(:pay)
    redirect_to :back
  end
end
