require 'pry'
require 'json'

module Helpers
  class << self
    def parse_json(file_path)
      JSON[File.read(file_path)]
    end
  end
end

module Calc
  class << self
    def normalize_weapon_damage(opts)
      ((opts['weapon_min'] + opts['weapon_max']) / 2.0) + (3.3 * opts['attack_power'] / 3.5)
    end

    def execute_damage(opts)
      # tooltip: (normalized_weapon_damge * exec_base_mod)
      # real:    (normalized_weapon_damge * 150%)
      # mods: mastery, seasoned_soldier, versatility, fury_hotfix
      {
        tooltip: (opts[:weapon] * 1.6 * DmgMod::mastery(opts[:mastery]) * DmgMod::seasoned_soldier * DmgMod::versatility(opts[:vers]) * DmgMod::fury_hotfix),
        real: (opts[:weapon] * 1.5 * DmgMod::mastery(opts[:mastery]) * DmgMod::seasoned_soldier * DmgMod::versatility(opts[:vers]) * DmgMod::fury_hotfix)
      }
    end

    def tc_damage(opts)
      # tooltip: (ap*.84) * 1.2
      # real:    (ap*.84) * 1.4
      # mods: versatility, tc_glyph, seasoned_soldier
      {
        tooltip: ((opts[:ap] * 0.84) * 1.2 * DmgMod::seasoned_soldier * DmgMod::tc_glyph * DmgMod::versatility(opts[:vers])),
        real: ((opts[:ap] * 0.84) * 1.4 * DmgMod::seasoned_soldier * DmgMod::tc_glyph * DmgMod::versatility(opts[:vers]))
      }
    end

    def ww_damage
      # tooltip: ((normalized_wep_dmg*2)*0.7)
      # real:    ((normalized_wep_dmg*2)*0.7)
      # mods: seasoned_soldier, versatility_mod
    end
  end
end

module DmgMod
  class << self
    def versatility(opts)
      ((opts * 0.011888111888111888) / 100.0 ) + 1.0
    end

    def mastery(opts)
      ((((opts + 880) * 0.03181988743) / 100) * (5.5/3.5) ) + 1.0
    end

    def seasoned_soldier
      1.1
    end

    def tc_glyph
      1.5
    end

    def fury_hotfix
      1.1
    end
  end
end

# Get character from file_path argument
char = Helpers::parse_json(ARGV[0])
char.each { |k, v| char[k] = char[k].to_f }

# Store the normalized weapon damage for further calculations
normalized_dmg = Calc::normalize_weapon_damage(char)

puts 'ThunderClap: '
puts Calc::tc_damage({ ap: char['attack_power'], vers: char['versatility'] })
puts 'Execute: '
puts Calc::execute_damage({ weapon: normalized_dmg, vers: char['versatility'], mastery: char['mastery'] })