class Transaction < ActiveRecord::Base
  self.inheritance_column = nil

  TYPE = ['inner']

  # :user, :type, :value, :deleted_at

  belongs_to :user, inverse_of: :transactions
  belongs_to :target, polymorphic: true

  acts_as_paranoid
  nilify_blanks before: :validation

  validates :type, presence: true, inclusion: { in: TYPE, allow_nil: false }
  validates :value, presence: true
  validates :user, presence: true

  STATES = ['pending', 'paid']
  state_machine :state, initial: :pending do
    event :pay do
      transition pending: :paid
    end

    after_transition any => :paid do |transaction, transition|
      if transaction.target.class == User
        transaction.target.class.update_counters(transaction.target.id, credit: 1000)
      else
        transaction.user.class.update_counters(transaction.user.id, credit: -transaction.value) if transaction.user.credit >= transaction.value
        transaction.target.pay if transaction.target.cost <= transaction.value
      end
    end
  end

  STATES.each do |state|
    scope state.to_sym, ->{ where(state: state) }
  end
end
