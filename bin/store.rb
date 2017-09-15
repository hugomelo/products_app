#!/bin/env ruby

require File.dirname(__FILE__) + '/../models/product'

product = Product.new 'Banana', 1.4

product.print_name

product.print_price
