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
  cs:          CsMod.new(multiplier: 1.3497, targets: @targets)
}

@abilities = {
  ww:       Whirlwind.new(name: 'Whirlwind', cost: 20.00, base: 2.00),
  ms:       MortalStrike.new(name: 'Mortal Strike', cost: 20.00, base: 2.251),
  ms_cs:    MortalStrike.new(name: 'Mortal Strike', cost: 20.00, base: 2.251, with: ['cs']),
  tc:       ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40),
  tc_cs:    ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['cs']),
  tc_g:     ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['tc_glyph']),
  tc_g_cs:  ThunderClap.new(name: 'Thunder Clap', cost: 10.00, base: 1.40, with: ['cs', 'tc_glyph']),
  ex_10:    Execute.new(name: 'Execute', cost: 10.00, base: 1.50),
  ex_40:    Execute.new(name: 'Execute', cost: 40.00, base: 1.50),
  ex_10_cs: Execute.new(name: 'Execute', cost: 10.00, base: 1.50, with: ['cs']),
  ex_40_cs: Execute.new(name: 'Execute', cost: 40.00, base: 1.50, with: ['cs'])
}

@table_data = @abilities.map { |k, ability| ability.table_data(@char, @reg_mods, @targets) }

@table_data.sort_by! { |ability| ability[@sorting || :dpr] }.reverse!

Formatador.display_line("[_black_][red]Arms Warrior DPR Calc v.0.1[/]")
Formatador.display_line()
Formatador.display_line("[_red_][black]#{@targets.to_i}_TARGET_PRIO[/]")
Formatador.display_table(@table_data, [:name, :cost, :raw, :dpr])
