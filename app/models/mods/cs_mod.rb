class CsMod < Mod
  attr_accessor :targets

  def initialize(args = {})
    super
    self.targets = args[:targets]
  end

  def apply(value, targets = 1)
    if targets == 1.5 || targets > 1.5
      ((value / targets) * multiplier) + ((value / targets) * (targets - 1.0))
    else
      value * multiplier
    end
  end
end