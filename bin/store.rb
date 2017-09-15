#!/bin/env ruby

require_relative '../config/environment'

if Product.count == 0
  Product.create! [
    {name: 'Banana', price: 1.4},
    {name: 'Apple',  price: 2.0},
    {name: 'Mango',  price: 3}
  ]
end

# === Assignment 1 ===

puts "-"*30
Product.first.print_name
Product.first.print_price

# === Assignment 2 ====

# Products' price sum
Product.print_products_sum

Product.print_cheapest_product
Product.print_most_expensive_product
