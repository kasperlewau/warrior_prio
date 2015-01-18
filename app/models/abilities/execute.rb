class Execute < Ability
  def filter(mods)
    local_mods = mods.select { |k,v| ['fury_hotfix', 'seasoned', 'mastery', 'versatility'].include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    pre_mods = normalize(char) * base
    pre_mods = (pre_mods + (pre_mods * 2)) if cost == 40
    filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }.to_f.round(2)
  end
end
