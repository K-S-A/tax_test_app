###############################################################################
# Module holds methods for argument validations.
###############################################################################
module Validator
  private

  def validate_arg!(param, type)
    raise ArgumentError, "Expected #{type} instead of #{param}" unless param.is_a?(type)
    param
  end

  def validate_respond_to!(*args, mthds)
    unless args.all? { |arg| mthds.all? { |m| arg.respond_to?(m) } }
      raise ArgumentError, "Expected all arguments to respond to #{mthds.join(', ')}"
    end
    args
  end
end
