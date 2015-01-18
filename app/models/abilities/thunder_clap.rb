class ThunderClap < Ability
  def filter(mods)
    local_mods = mods.select { |k,v| ['seasoned', 'versatility', 'tc_glyph'].include? k.to_s }
    local_mods
  end

  def calc(char, mods, targets)
    pre_mods = ((char.attack_power * 0.84) * base) * targets
    filter(mods).values.reduce(pre_mods) { |val, mod| mod.apply(val) }.to_f.round(2)
  end
end
