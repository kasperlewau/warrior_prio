class MortalStrike < Ability
  def initialize(args = {})
    super
    self.name = "#{args[:name]} #{args[:with]}"
    self.additional_mods = args[:with] || []
  end

  def filter(mods)
    filter     = additional_mods.concat(['seasoned', 'mastery', 'versatility'])
    local_mods = mods.select { |k,v| filter.include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    pre_mods = normalize(char) * base
    filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }
  end
end