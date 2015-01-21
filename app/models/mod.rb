class Mod
  attr_accessor :multiplier

  def initialize(args = {})
    self.multiplier = args[:multiplier]
  end

  def apply(value, targets = nil)
    value * multiplier
  end
end
