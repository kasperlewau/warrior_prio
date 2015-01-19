### Execution

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
