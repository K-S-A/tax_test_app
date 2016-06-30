require_relative './modules/file_export'
require_relative './modules/validator'

class Cart
  include FileExport
  include Validator

  attr_reader :items

  def initialize(*args)
    @items = validate_respond_to!(*args, [:price, :tax, :to_s])
  end

  def total
    sum_for(:price)
  end

  def tax
    sum_for(:tax)
  end

  def to_s
    data = items.map(&:to_s) << "\nSales Taxes: #{tax}" << "Total: #{total}"
    data.join("\n")
  end

  private

  def sum_for(param)
    items.map(&param).reduce(0) { |a, e| a + e }.round(2)
  end
end
