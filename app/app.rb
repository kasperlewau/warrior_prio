require 'bundler/setup'
Bundler.require

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
@targets = (ARGV[1] || 1).to_f
@targets = @targets + 0.5 if @targets > 1
@sorting = ARGV[2].to_sym unless ARGV[2].nil?

@reg_mods = {
  fury_hotfix: Mod.new(multiplier: 1.10), # TODO: Move into the Execute class?
  seasoned:    Mod.new(multiplier: 1.10),
  mastery:     Mod.new(multiplier: @char.mastery),
  versatility: Mod.new(multiplier: @char.versatility),
  tc_glyph:    Mod.new(multiplier: 1.50), # TODO: Make it conditional.
  ww_hotfix:   Mod.new(multiplier: 0.70), # TODO: Move into the Whirlwind class?
  cs:          Mod.new(multiplier: 1.35), # TODO: Don't double dip on multitargets (i.e. should only affect current target)
}

@abilities = {
  execute:                 Execute.new(name: 'Execute', cost: 25.00, base: 1.50),
  execute_10:              Execute.new(name: 'Execute', cost: 10.00, base: 1.50),
  execute_40:              Execute.new(name: 'Execute', cost: 40.00, base: 1.50),
  execute_10_cs:           Execute.new(name: 'Execute', cost: 10.00, base: 1.50, with: ['cs']),
  execute_40_cs:           Execute.new(name: 'Execute', cost: 40.00, base: 1.50, with: ['cs']),
  thunder_clap_glyphed_cs: ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['tc_glyph', 'cs']),
  thunder_clap_glyphed:    ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['tc_glyph']),
  thunder_clap_cs:         ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['cs']),
  thunder_clap:            ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40),
  whirlwind:               Whirlwind.new(name: 'Whirlwind', cost: 20.00, base: 2.00),
  mortal_strike:           MortalStrike.new(name: 'Mortal Strike', cost: 20.00, base: 2.251),
  mortal_strike_cs:        MortalStrike.new(name: 'Mortal Strike', cost: 20.00, base: 2.251, with: ['cs'])
}

def build_table_entry_for(ability)
  {
    name: ability.name,
    cost: ability.cost,
    raw:  ability.calc(@char, @reg_mods, @targets).to_f.round(2),
    dpr:  ability.dpr(@char, @reg_mods, @targets).to_f.round(2),
  }
end


@table_data = @abilities.map { |k, v| build_table_entry_for(v) }

@table_data.sort_by! { |ability| ability[@sorting || :dpr] }.reverse!
Formatador.display_line("[_black_][red]Arms Warrior DPR Calc v.0.1[/]")
Formatador.display_line()
Formatador.display_line("[_red_][black]#{@targets.to_i}_TARGET_PRIO[/]")
Formatador.display_table(@table_data, [:name, :cost, :raw, :dpr])
