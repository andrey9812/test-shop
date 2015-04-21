class InvoicesPolicy
  attr_reader :user, :invoices

  def initialize(user, invoices)
    @user = user
    @invoices = invoices
  end

  def show?
    true
  end

  def create?
    (!user.guest? && user.companies.any?) || user.admin?
  end

  alias :manage? :create?
  alias :update? :create?
  alias :destroy? :create?
end