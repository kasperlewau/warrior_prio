class Character
  attr_accessor :weapon_min, :weapon_max, :attack_power, :mastery, :versatility

  def initialize(args = {})
    self.weapon_min   = args[:weapon_min].to_f
    self.weapon_max   = args[:weapon_max].to_f
    self.attack_power = args[:attack_power].to_f
    self.mastery      = MasteryMod.new.apply(args[:mastery].to_f)
    self.versatility  = VersatilityMod.new.apply(args[:versatility].to_f)
  end
end