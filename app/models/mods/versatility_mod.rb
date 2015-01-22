class VersatilityMod < Mod
  BASE      = 100
  PER_POINT = 0.01171581769

  def apply(value)
    (((value + BASE) * PER_POINT) / 100.0 ) + 1.0
  end
end
