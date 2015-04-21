class Invoice < ActiveRecord::Base

  # :user, :payment_transaction, :email, :cost, :deleted_at

  belongs_to :user, inverse_of: :invoices
  has_many :transactions, as: :target, inverse_of: :target, class_name: 'Transaction'
  has_and_belongs_to_many :products, join_table: :products_invoices

  acts_as_paranoid
  nilify_blanks before: :validation

  validates :email, presence: true
  validates :cost, presence: true
  validates :user, presence: true

  after_commit on: :create do
    if self.transactions.empty?
      self.transactions.create(value: self.cost, user: self.user, type: 'inner').try(:pay)
    end
  end

  scope :by_date, -> { order( 'created_at DESC' ) }

  STATES = ['pending', 'paid']
  state_machine :state, initial: :pending do
    event :pay do
      transition pending: :paid
    end
  end

  STATES.each do |state|
    scope state.to_sym, ->{ where(state: state) }
  end
end
