class Execute < Ability
  @@ability_mods = ['mastery', 'fury_hotfix']

  def initialize(args = {})
    super
    mods.concat(@@ability_mods).concat(args[:with] || []).uniq!
  end

  def filter(mods)
    mods.select { |k,v| self.mods.include? k.to_s }
  end

  def apply_mods(value, mods)
    mods.values.reduce(value) { |val, mod|  mod.apply(val) }
  end

  def calc(char, mods, targets)
    value = (normalize(char) * base)
    value = value * ((cost/40) * 4) if cost > 10
    apply_mods(value, filter(mods))
  end
end