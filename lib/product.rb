require_relative './modules/validator'

class Product
  include Validator

  attr_reader :name, :price

  def initialize(name, price)
    @name = validate_arg!(name, String)
    @price = validate_arg!(price, Float)
  end
end
