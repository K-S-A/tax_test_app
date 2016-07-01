require_relative './modules/validator'

###############################################################################
# This class holds name and base price of product.
# Available public methods:
# name => return name of product as String
# price => return price of product as Float
###############################################################################
class Product
  include Validator

  attr_reader :name, :price

  def initialize(name, price)
    @name = validate_arg!(name, String)
    @price = validate_arg!(price, Float)
  end
end
