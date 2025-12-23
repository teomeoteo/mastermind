require_relative 'game'

COLORS = {
  'red'    => "\e[31m●\e[0m",
  'green'  => "\e[32m●\e[0m",
  'blue'   => "\e[38;5;21m●\e[0m",
  'yellow' => "\e[33m●\e[0m",
  'purple' => "\e[38;5;57m●\e[0m",
  'orange' => "\e[38;5;208m●\e[0m",
}.freeze

game = Game.new
game.start
