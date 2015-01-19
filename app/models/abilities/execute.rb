class Execute < Ability
  def initialize(args = {})
    super
    self.name = "#{args[:name]}@#{args[:cost]} #{args[:with]}"
    self.additional_mods = args[:with] || []
  end

  def filter(mods)
    filter     = additional_mods.concat(['fury_hotfix', 'seasoned', 'mastery', 'versatility'])
    local_mods = mods.select { |k,v| filter.include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    return @result unless @result.nil?
    pre_mods = normalize(char) * base
    pre_mods = pre_mods * ((cost/40) * 4) if cost > 10
    @result ||= filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }.to_f.round(2)
  end
end
