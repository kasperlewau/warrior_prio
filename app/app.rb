require 'pry'
require 'json'
require 'formatador'

require_relative 'modules/helpers'

require_relative 'models/character'

require_relative 'models/ability'
require_relative 'models/abilities/execute'
require_relative 'models/abilities/thunder_clap'
require_relative 'models/abilities/whirlwind'
require_relative 'models/abilities/mortal_strike'

require_relative 'models/mod'
require_relative 'models/mods/mastery_mod'
require_relative 'models/mods/versatility_mod'

@char    = Character.new(Helpers::parse_json(ARGV[0]))
@targets = (ARGV[1] || 1).to_i

@reg_mods = {
  fury_hotfix: Mod.new(multiplier: 1.10), # TODO: Move into the Execute class?
  seasoned:    Mod.new(multiplier: 1.10),
  mastery:     Mod.new(multiplier: @char.mastery),
  versatility: Mod.new(multiplier: @char.versatility),
  tc_glyph:    Mod.new(multiplier: 1.5),  # TODO: Make it conditional.
  ww_hotfix:   Mod.new(multiplier: 0.70), # TODO: Move into the Whirlwind class?
  cs:          Mod.new(multiplier: 1.35), # TODO: Implement into formulas. Conditional CLI argument?
  sweeping:    Mod.new(multiplier: 0.50), # TODO: Implement into formulas. Based on amount of targets specified.
}

@abilities = {
  execute_10:    Execute.new(name: 'Execute', cost: 10, base: 1.50),
  execute_40:    Execute.new(name: 'Execute', cost: 40, base: 1.50),
  thunder_clap:  ThunderClap.new(name: 'Thunder Clap', cost: 10, base: 1.20),
  whirlwind:     Whirlwind.new(name: 'Whirlwind', cost: 20, base: 2.00),
  mortal_strike: MortalStrike.new(name: 'Mortal Strike', cost: 20, base: 2.251)
}

def build_table_entry_for(ability)
  {
    name: ability.name,
    cost: ability.cost,
    raw:  ability.calc(@char, @reg_mods, @targets),
    dpr:  ability.dpr(@char, @reg_mods, @targets),
  }
end


@table_data = @abilities.map { |k, v| build_table_entry_for(v) }

@table_data.sort_by! { |ability| ability[:dpr] }.reverse!
Formatador.display_line()
Formatador.display_line("[_red_][black]#{@targets}_TARGET_PRIO[/]")
Formatador.display_table(@table_data, [:name, :cost, :raw, :dpr])
