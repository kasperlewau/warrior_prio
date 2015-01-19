## Ability prio calculator for WoW Warriors.
CLI tool designed to calculate the highest DPR ability for Arms Warriors.

### Steps

**For the time being, this script is restricted to being used on UNIX based machines (or Windows, if you can install Ruby on it (good luck...)).**

* Clone the repo (or download as .zip)
```
git clone git@github.com:RushPlay/casino-saga.git
https://github.com/kasperlewau/warrior_prio/archive/master.zip
```
* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* Install the correct version of Ruby

>There is currently no specified Ruby version for the script, as such it may run on older versions.
Developed under Ruby 2.1.5

* Install the Bundler gem
```
gem install bundler
```
* CD into the root directory of the script.
* Install the bundle.
```
bundle install
```
* Input your charcter data into a .json file
```
{
  // The low end value of your Weapon.
  "weapon_min":   "1442",
  // The top end value of your Weapon.
  "weapon_max":   "2163",
  // Your raw attack power (buffed, unbuffed - up to you).
  "attack_power": "4608",
  // Mastery value in points as seen on your character sheet (EXLUDING BASE)
  "mastery":      "533",
  // Versatility value in points as seen on your character sheet (INCLUDING BASE)
  "versatility":  "715"
}
```
* Run the script
```ruby app.rb [character] [targets] [sorting]``` where
  * **[character]** is the .json file you just created
  * **[targets]** is the amount of targets you wish to calculate for
    * *Defaults to 1*
  * **[sorting]** is the parameter you wish to sort the output table by. Can be one of
    * *Defaults to DPR.*
    * 'name' - Spell Name
    * 'cost' - Rage cost for spell
    * 'raw'  - Raw damage output
    * 'dpr'  - Damage per rage


### Example
```
// Runs the script with my character info, on three targets and sorts by the raw damage output.
ruby app.rb my_character.json 3 raw
```

![example_output_image](https://s3.amazonaws.com/f.cl.ly/items/1v242s2d2B0s1b1F463R/Image%202015-01-19%20at%201.32.23%20pm.png)


## Currently known bugs
* Colossus Smash calculates on multiple targets
  * As such, multi-target calculations are **not** reliable at this time.
* Sweeping Strikes is not accounted for in multi-target situations.

## TODO
* Add specs (I suck).
* Package into a Windows executable.
* Add imports from Battle.net.
* Add missing abilities.

## Contributing
Post an issue, send a PR (preferablly with accompanying unit tests) or ping me somewhere with your suggestions:
```
@btag: kappe#2789
@mmo-champion: kaappe
```

## License
MIT