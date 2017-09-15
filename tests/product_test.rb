require 'test/unit'
require_relative '../config/environment'

# Product class tests
class ProductTest < Test::Unit::TestCase

  def setup
    Product.destroy_all
  end

  test 'it should calc the sum of all products' do
    Product.create [
      {name: "banana", price: 45.11},
      {name: "papaya", price: 10},
      {name: "apple", price: 14.1},
      {name: "mango", price: 20}
    ]

    assert_equal 89.21, Product.prices_sum.to_f
    assert_equal 89.21, Product.prices_sum(Product.all).to_f
  end

  test 'it should get the cheapest product' do
    Product.create [
      {name: "banana", price: 45.11},
      {name: "papaya", price: 10},
      {name: "apple", price: 14.1},
      {name: "mango", price: 20}
    ]

    assert_equal "papaya", Product.cheapest.name
    assert_equal "papaya", Product.all.cheapest.name
  end

  test 'it should get the most expensive product' do
    Product.create [
      {name: "banana", price: 45.11},
      {name: "papaya", price: 10},
      {name: "apple", price: 14.1},
      {name: "mango", price: 20}
    ]

    assert_equal "banana", Product.most_expensive.name
    assert_equal "banana", Product.all.most_expensive.name
  end
end
