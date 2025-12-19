COLORS = {
  'red'    => "\e[31m●\e[0m",
  'green'  => "\e[32m●\e[0m",
  'blue'   => "\e[34m●\e[0m",
  'yellow' => "\e[33m●\e[0m",
  'purple' => "\e[35m●\e[0m",
  'orange' => "\e[38;5;208m●\e[0m",
}.freeze

class Game
  attr_accessor :board, :secret_code
  def initialize(board)
    @board = board
    @secret_code = set_code
  end

  def start
  end

  def set_code
    COLORS.keys.sample(board.rows[0].holes.length)
  end
end

class Player
end

class Row
  attr_accessor :holes
  def initialize(hole_count) # number of holes
    @holes = make(hole_count.to_int)
  end

  def make(holes)
    total_holes = []
    holes.times do
      total_holes << Hole.new('empty')
    end
    total_holes
  end

  def render
    holes.each do |hole|
      hole.render
    end
    print "\n"
  end

  Hole = Struct.new(:state) do 
    def update_state(state)
      self.state = state
    end
    
    def render
      if (self.state == 'empty')
        print "○ "
      else
        print "#{COLORS[self.state]} "
      end
    end
  end
end

class Board
  attr_accessor :rows
  def initialize(row = Row.new(4))
    @rows = make(row)
  end
  def render
    rows.each do |row|
      row.render
    end
  end

  def make(row)
    Array.new(12) {row}
  end
end

class Player
  def input(board)
    puts "Choose 4 colors in order 1 by 1"
  end
end

class Feedback
  def initialize(row = Row.new(4))
    @display = row.render
  end
end

game = Game.new(Board.new(Row.new(4)))
game.board.render
