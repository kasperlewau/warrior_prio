class ThunderClap < Ability
  @@ability_mods = []

  def initialize(args = {})
    super
    mods.concat(@@ability_mods).concat(args[:with] || []).uniq!
  end

  def filter(mods)
    mods.select { |k,v| self.mods.include? k.to_s }
  end

  def apply_mods(value, mods)
    mods.values.reduce(value) { |val, mod| mod.apply(val) }
  end

  def calc(char, mods, targets)
    value = ((char.attack_power * 0.84) * base) * targets
    apply_mods(value, filter(mods))
  end
end