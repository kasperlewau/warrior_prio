class MasteryMod < Mod
  BASE      = 880
  PER_POINT = 0.03181988743
  HOTFIX    = (5.5/3.5)

  def apply(value)
    ((((value + BASE) * PER_POINT) / 100) * HOTFIX ) + 1.0
  end
end
