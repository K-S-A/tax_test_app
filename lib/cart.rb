require_relative './modules/file_export'
require_relative './modules/validator'

###############################################################################
# This class holds collection of items that have 'price' and 'tax' attributes.
# Available public methods:
# #total => return sum of items prices (including tax)
#           as Float (rounded to 2 decimal places).
# #tax => return sum of items taxes as Float (rounded to 2 decimal places).
# #to_s => return multiline string with information about items and
#          sales tax and total.
###############################################################################
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
    items.map(&param).reduce(0, :+).round(2)
  end
end
