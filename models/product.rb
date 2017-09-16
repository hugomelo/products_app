# Product class
# Supports name and price fields
# Prints out all the calculations
# Also, supports VAT fixed input and percentange output
#
class Product < ActiveRecord::Base
  # fix it to support only $
  CURRENCY = '$'

  ### Associations
  belongs_to :parent, class_name: "Product"
  has_many   :products, class_name: "Product", foreign_key: :parent_id

  ### Validations
  validates :name, presence: true
  validates_numericality_of :price,      greater_than_or_equal_to: 0
  validates_numericality_of :input_vat,  greater_than_or_equal_to: 0
  validates_numericality_of :output_vat, greater_than_or_equal_to: 0
  validate :has_proper_vat
  validate :has_other_parent

  ### Scopes
  scope :cheapest,                -> { order("price ASC" )         .limit(1).first }
  scope :most_expensive,          -> { order("price DESC")         .limit(1).first }
  scope :cheapest_with_vat,       -> { order("price_with_vat ASC" ).limit(1).first }
  scope :most_expensive_with_vat, -> { order("price_with_vat DESC").limit(1).first }

  def to_s
    puts "Product NAME: #{name} PRICE: #{price_with_currency}"
  end

  # generic mode. For real use it would be good to use locale instead
  def price_with_currency price = nil
    price ||= self.price
    "#{CURRENCY}#{price.to_f}"
  end

  ### VAT: Adjust the price_with_vat everytime it's composition is changed
  def price= price
    super(price)
    self.adjust_price_with_vat
  end

  def output_vat= vat
    super(vat)
    self.adjust_price_with_vat
  end

  def input_vat= vat
    super(vat)
    self.adjust_price_with_vat
  end

  def self.prices_sum products = nil
    products ||= self.all

    products.pluck(:price).reduce(0, :+)
  end

  def self.prices_sum_with_vat products = nil
    products ||= self.all

    products.pluck(:price_with_vat).reduce(0, :+)
  end

  ### PRINTING METHODS
  def print_name
    puts "Name: #{name}"
  end

  def print_price
    puts "Price: #{price_with_currency}"
  end

  def print_price_with_vat
    puts "Price with VAT: #{price_with_currency(price_with_vat)}"
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

  protected
  def adjust_price_with_vat
    self.price_with_vat = ((1 + output_vat/100)*price - input_vat).round(2)
  end

  def has_proper_vat
    if (self.output_vat / 100 * self.price - self.input_vat) < 0
      errors.add(:output_vat, "Output VAT cannot produce a negative tax")
    end
  end

  def has_other_parent
    errors.add(:parent_id, "parent id cannot be same as child's.") if self.parent_id.present? && self.parent_id == self.id
  end

end
