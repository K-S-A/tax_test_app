#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.require

require './spec/helpers'

Dir["#{File.expand_path(File.dirname(__FILE__))}/lib/*.rb"].each do |file|
  require file
end

io = Class.new { include Helpers }

params = io.data_from_file('product_params')

cart_items = params.map do |h|
  CartItem.new(Product.new(h['name'], h['base_price']), h['quantity'])
end

# Input 1
Cart.new(*cart_items[0..2]).export_to('cart1.csv')

# Input 2
Cart.new(*cart_items[3..4]).export_to('cart2.csv')

# Input 3
Cart.new(*cart_items[5..8]).export_to('cart3.csv')
