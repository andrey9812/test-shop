class Products::Image < ActiveRecord::Base
  self.table_name = 'product_images'

  # :asset, :main

  belongs_to :product, inverse_of: :images

  mount_uploader :asset, Product::ImageUploader

  scope :main, -> { where(main: true) }
end
