class MasteryMod < Mod
  BASE      = 880
  PER_POINT = 0.04091074681

  def apply(value)
    (((value + BASE) * PER_POINT) / 100) + 1.0
  end
end
