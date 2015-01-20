require 'bundler/setup'
Bundler.require
require_relative 'requires'

@char    = Character.new(Helpers::parse_json(ARGV[0]))
@targets = (ARGV[1] || 1).to_f
@targets = @targets + 0.5 if @targets > 1
@sorting = ARGV[2].to_sym unless ARGV[2].nil?

@reg_mods = {
  fury_execute_hotfix: Mod.new(multiplier: 1.10),
  seasoned:    Mod.new(multiplier: 1.10),
  mastery:     Mod.new(multiplier: @char.mastery),
  versatility: Mod.new(multiplier: @char.versatility),
  tc_glyph:    Mod.new(multiplier: 1.50),
  ww_hotfix:   Mod.new(multiplier: 0.70),
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
}

@table_data = @abilities.map { |k, ability| ability.table_data(@char, @reg_mods, @targets) }

@table_data.sort_by! { |ability| ability[@sorting || :dpr] }.reverse!

Formatador.display_line("[_black_][red]Arms Warrior DPR Calc v.0.1[/]")
Formatador.display_line()
Formatador.display_line("[_red_][black]#{@targets.to_i}_TARGET_PRIO[/]")
Formatador.display_table(@table_data, [:name, :cost, :raw, :dpr])
