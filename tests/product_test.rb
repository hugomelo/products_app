require_relative './test_helper'

# Product class tests
class ProductTest < Test::Unit::TestCase

  def setup
    setup_database
    Product.create! [
      {name: "banana", price: 45.11, output_vat: 10, input_vat: 2},
      {name: "papaya", price: 10   , output_vat: 20, input_vat: 1},
      {name: "apple",  price: 14.1 , output_vat: 1, input_vat: 10},
      {name: "mango",  price: 20   , output_vat: 300,  input_vat: 2}
    ]
  end

  test 'it should calc the sum of all products' do
    assert_equal 89.21, Product.prices_sum.to_f
    assert_equal 89.21, Product.prices_sum(Product.all).to_f
  end

  test 'it should get the cheapest product' do
    assert_equal "papaya", Product.cheapest.name
    assert_equal "papaya", Product.all.cheapest.name
  end

  test 'it should get the most expensive product' do
    assert_equal "banana", Product.most_expensive.name
    assert_equal "banana", Product.all.most_expensive.name
  end

  ### VAT
  test 'it calcs the new price with VAT field whenever input_vat, output_vat or price is changed' do
    product = Product.first

    #output
    price_with_vat = product.price_with_vat
    product.update output_vat: product.output_vat+1
    assert_not_equal price_with_vat, product.price_with_vat

    #input
    price_with_vat = product.price_with_vat
    product.update input_vat: product.input_vat+1
    assert_not_equal price_with_vat, product.price_with_vat

    #price
    price_with_vat = product.price_with_vat
    product.update price: product.price+10
    assert_not_equal price_with_vat, product.price_with_vat
  end

  test 'it should calc the sum of all products with VAT' do
    total = Product.all.inject(0) {|total,p| total += p.price * (1 + p.output_vat/100) - p.input_vat }.round(2)
    assert_equal total, Product.prices_sum_with_vat.to_f
    assert_equal total, Product.prices_sum_with_vat(Product.all).to_f
  end

  test 'it should get the cheapest product with VAT' do
    assert_equal "apple", Product.cheapest_with_vat.name
    assert_equal "apple", Product.all.cheapest_with_vat.name
  end

  test 'it should get the most expensive product with VAT' do
    assert_equal "mango", Product.most_expensive_with_vat.name
    assert_equal "mango", Product.all.most_expensive_with_vat.name
  end


end
