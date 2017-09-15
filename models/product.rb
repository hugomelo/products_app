# Product class
# Supports name and price fields
# Print out the class name with name and price
# Print out name and price separated
class Product < ActiveRecord::Base
  # fix it to support only $
  CURRENCY = '$'

  validates :name, presence: true
  validates :price, presence: true

  scope :cheapest,       -> { order("price ASC" ).limit(1).first }
  scope :most_expensive, -> { order("price DESC").limit(1).first }

  def to_s
    puts "Product NAME: #{name} PRICE: #{price_with_currency}"
  end

  # generic mode. For real use it would be good to use locale instead
  def price_with_currency price = nil
    price ||= self.price
    "#{CURRENCY}#{price.to_f}"
  end

  def self.prices_sum products = nil
    products ||= self.all

    products.pluck(:price).reduce(0, :+)
  end

  ### PRINTING METHODS
  def print_name
    puts "Name: #{name}"
  end

  def print_price
    puts "Price: #{price_with_currency}"
  end

  def self.print_products_sum products = nil
    products ||= self.all

    price = prices_sum products
    puts "products sum: #{CURRENCY}#{price.to_f}"
  end

  def self.print_by_price_ordering type, products = nil
    return unless [:cheapest, :most_expensive].include? type
    products ||= self.all

    puts '-'*30
    if type == :cheapest
      puts 'cheapest product:'
      product = products.cheapest
    else
      puts 'most expensive product:'
      product = products.most_expensive
    end

    product.print_name
    product.print_price
  end

  def self.print_cheapest_product products = nil
    self.print_by_price_ordering :cheapest
  end
  def self.print_most_expensive_product products = nil
    self.print_by_price_ordering :most_expensive
  end
end
