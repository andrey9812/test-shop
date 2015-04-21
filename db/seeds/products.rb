Product.destroy_all
ActiveRecord::Base.connection.execute(<<-EOS)
  ALTER SEQUENCE IF EXISTS products_id_seq RESTART WITH 1;
EOS

(0..10).each do
  product = Product.create! do |e|
    e.title = Faker::Commerce.product_name
    e.description = Faker::Lorem.sentence
    e.price = Faker::Commerce.price
    e.maker = Faker::Company.name
    e.count = rand(0...10)
    
    e.images.new(remote_asset_url: "http://lorempixel.com/1200/900/#{['fashion','transport','nightlife', 'sports', 'business'].sample}", main: true)
  end
  product.activate!
end
