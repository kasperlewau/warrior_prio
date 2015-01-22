class Whirlwind < Ability
  def initialize(args = {})
    super
    @ability_mods = ['ww_hotfix']
    mods.concat(@ability_mods).concat(args[:with] || []).uniq!
  end

  def filter(mods)
    mods.select { |k,v| self.mods.include? k.to_s }
  end

  def apply_mods(value, mods, targets)
    mods.values.reduce(value) { |val, mod| mod.apply(val, targets) }
  end

  def calc(char, mods, targets)
    value = ((normalize(char) * base) * targets.to_i)
    apply_mods(value, filter(mods), targets.to_i)
  end
end