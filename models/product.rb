# Product class
# Supports name and price fields
# Print out the class name with name and price
# Print out name and price separated
class Product
  attr_accessor :name, :price
  attr_reader :currency

  DEFAULTS = {
    currency: '$'
  }.freeze

  def initialize(name = '', price = '')
    @name = name
    @price = price
    @currency = DEFAULTS[:currency]
  end

  def to_s
    puts "Product NAME: #{name} PRICE: #{price_with_currency}"
  end

  def print_name
    puts "Name: #{name}"
  end

  def print_price
    puts "Price: #{price_with_currency}"
  end

  # generic mode. For real use it would be good to use locale instead
  def price_with_currency
    "#{currency}#{price}"
  end
end
