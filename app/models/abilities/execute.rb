class Execute < Ability
  @@max_targets  = 1.5
  @@ability_mods = ['mastery', 'fury_execute_hotfix']

  def filter(mods)
    mods.select { |k,v| self.mods.include? k.to_s }
  end

  def apply_mods(value, mods, targets)
    mods.values.reduce(value) { |val, mod|  mod.apply(val, targets) }
  end

  def get_targets(targets)
    targets > @@max_targets ? @@max_targets : targets
  end

  def calc(char, mods, targets)
    targets = get_targets(targets)
    value   = (normalize(char) * base) * targets
    value   = value * ((cost/40) * 4) if cost > 10
    apply_mods(value, filter(mods), targets)
  end
end