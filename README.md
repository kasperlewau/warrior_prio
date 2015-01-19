## Ability prio calculator for WoW Warriors.
CLI tool designed to calculate the highest DPR ability for Arms Warriors.

### [Installation Instructions](docs/installation.md)

### [Execution Instructions](docs/execution.md)

### Example Run
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