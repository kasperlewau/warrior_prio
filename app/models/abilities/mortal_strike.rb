class MortalStrike < Ability
  @@max_targets  = 1.5
  @@ability_mods = ['mastery']

  def initialize(args = {})
    super
    mods.concat(@@ability_mods).concat(args[:with] || []).uniq!
  end

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
    apply_mods(((normalize(char) * base) * targets), filter(mods), targets)
  end
end