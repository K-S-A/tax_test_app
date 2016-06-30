require_relative './modules/validator'

class CartItem
  include Validator

  attr_reader :product, :quantity

  def initialize(product, quantity = 1)
    @product, = validate_respond_to!(product, [:name, :price])
    @quantity = validate_arg!(quantity, Integer)
  end

  def tax
    round_tax(product.price * (basic_tax_rate + import_tax_rate) / 100.0)
  end

  def price
    (product.price + tax).round(2)
  end

  def name
    product.name
  end

  def to_s
    "#{quantity}, #{product.name}, #{price}"
  end

  private

  def basic_tax_rate
    product.name =~ /(book)|(chocolate)|(pills)/ ? 0 : 10
  end

  def import_tax_rate
    product.name =~ /imported/ ? 5 : 0
  end

  def round_tax(value)
    (value * 20).round / 20.0
  end
end
