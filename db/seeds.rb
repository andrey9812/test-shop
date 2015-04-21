unless Rails.env.production?
  require File.join(File.dirname(__FILE__), 'seeds/products.rb')
end
