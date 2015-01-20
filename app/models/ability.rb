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

  def table_data(char, mods, targets)
    {
      name: name,
      cost: cost.to_i,
      raw:  calc(char, mods, targets).to_f.round(2),
      dpr:  dpr(char, mods, targets).to_f.round(2),
    }
  end
end
