class Product < ActiveRecord::Base

  # :title, :description, :maker, :price, :count, :properties, :images

  has_one :cover, ->{ where(main: true) }, class_name: 'Products::Image'
  has_many :images, dependent: :destroy, class_name: 'Products::Image', inverse_of: :product

  accepts_nested_attributes_for :images, allow_destroy: true

  nilify_blanks before: :validation

  validates :title, presence: true
  validates :price, presence: true
  validates :count, presence: true

  scope :random, -> { order( 'RANDOM()' ) }
  scope :alphavit, -> { order( 'title ASC' ) }
  scope :date, -> { order( 'created_at DESC' ) }
  scope :price, -> { order( 'price DESC' ) }

  STATES = ['pending', 'active']
  state_machine :state, initial: :pending do
    event :activate do
      transition pending: :active
    end

    event :deactivate do
      transition active: :pending
    end
  end

  STATES.each do |state|
    scope state.to_sym, ->{ where(state: state) }
  end

  def to_param
    self.title.present? ? "#{self.id}-#{Russian.translit(self.title).parameterize}" : self.id.to_s
  end
end
