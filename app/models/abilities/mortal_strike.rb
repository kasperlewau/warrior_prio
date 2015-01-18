class MortalStrike < Ability
  def filter(mods)
    local_mods = mods.select { |k,v| ['seasoned', 'mastery', 'versatility'].include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    pre_mods = normalize(char) * base
    filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }.to_f.round(2)
  end
end