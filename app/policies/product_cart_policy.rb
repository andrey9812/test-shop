class ProductCartPolicy
  attr_reader :user, :cart

  def initialize(user, cart)
    @user = user
    @cart = cart
  end

  def show?
    user.present?
  end

  alias :add? :show?
  alias :update? :show?
  alias :destroy? :show?
end