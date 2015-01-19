class ThunderClap < Ability
  def initialize(args = {})
    super
    self.name = "#{args[:name]} #{args[:with]}"
    self.additional_mods = args[:with] || []
  end

  def filter(mods)
    filter     = additional_mods.concat(['seasoned', 'versatility'])
    local_mods = mods.select { |k,v| filter.include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    pre_mods = ((char.attack_power * 0.84) * base) * targets
    filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }.to_f.round(2)
  end
end
