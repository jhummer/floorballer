#  FloorBaller

My first SwiftUI iOS app. Used by local floorball group to handle confusion over who should play who during Sunday floorball.


## Usage

First view is the settings view where you choose number of teams, toggle if timer should be shown together with the game length in minutes.

Second view is the generated game schedule with the optional timer. The generated game schedule spreads games evenly among teams so no "why do we have to wait again" discussions should arise.
  
The logic for the game schedule takes into account that no team should play two consecutive games in a row if possible.  

## Credits

The timer view is pretty much a straight copy-paste with minor modifications from Finsi Ennes:

https://medium.com/geekculture/build-a-stopwatch-in-just-3-steps-using-swiftui-778c327d214b



<p float="left">
<img src="https://github.com/jhummer/jhummer.github.io/blob/main/images/floorballer-splash.png" width="282">

<img src="https://github.com/jhummer/jhummer.github.io/blob/main/images/floorballer-settings.png" width="282">

<img src="https://github.com/jhummer/jhummer.github.io/blob/main/images/floorballer-gamelist.png" width="282">
</p>
