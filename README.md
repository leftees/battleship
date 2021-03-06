# Ruby Implementation of Battleship game

[![Code Climate](https://codeclimate.com/github/szymon33/battleship/badges/gpa.svg)](https://codeclimate.com/github/szymon33/battleship)
[![Test Coverage](https://codeclimate.com/github/szymon33/battleship/badges/coverage.svg)](https://codeclimate.com/github/szymon33/battleship/coverage)

The Battleship is an application which implements [Battleship (game)](https://en.wikipedia.org/wiki/Battleship_(game)) in Ruby language. This document contains implementation notes and gotcha's.

## Usage notes

* You can use the game like in the following file: [console.rb](lib/console.rb)

* You could test/play by yourself in interactive mode/console by typing

   ```ruby
   ruby lib/console.rb
   ```

*  The ships cannot overlap (i.e., only one ship can occupy any given square in the grid). This is variant when ships can tauch only diagonal.

  bad

      ..........
      ..XXX.....
      ....XXX...
      ..........

  bad

      ..........
      ..XXXXXX..
      ..........
      ..........

  good

      ..........
      ..XXX.....
      .....XXX..
      ..........

## List of available commands

* D - debug mode

* I - initialize game again with new fleet

* Q - quit

## Specs

Test coverage can be observed in the badge on the top of this file. If I find more time then I will try to improve it.

## End of the game

* Game ends when you destory all the enemy's ships

* Game ends when you type command 'Q'

## Screenshots

![Screentshot](screenshot1.png)

![Screentshot](screenshot2.png)
