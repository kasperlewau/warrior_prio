class VersatilityMod < Mod
  PER_POINT = 0.011888111888111888

  def apply(value)
    ((value * PER_POINT) / 100.0 ) + 1.0
  end
end
