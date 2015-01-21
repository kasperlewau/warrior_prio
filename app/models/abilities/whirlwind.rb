class Whirlwind < Ability
  @@ability_mods = ['ww_hotfix']

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
    apply_mods(((normalize(char) * base) * targets.to_i), filter(mods))
  end
end