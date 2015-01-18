class Mod
  attr_accessor :multiplier

  def initialize(args = {})
    self.multiplier = args[:multiplier]
  end

  def apply(value)
    value * multiplier
  end
end
