class Ability
  DEFAULT_MODS = ['seasoned', 'versatility']

  attr_accessor :name, :base, :cost, :mods

  def initialize(args = {})
    self.base  = args[:base]
    self.name  = "#{args[:name]} #{args[:with]}"
    self.mods  = Array(args[:mods]).concat(DEFAULT_MODS)
    self.cost  = args[:cost]
  end

  def normalize(char)
    (((char.weapon_min + char.weapon_max) / 2) + (3.3 * char.attack_power / 3.5))
  end

  def dpr(char, mods, targets)
    (calc(char, mods, targets) / cost)
  end
end
