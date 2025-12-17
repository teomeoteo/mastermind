COLORS = {
  'red'    => "\e[31m●\e[0m",
  'green'  => "\e[32m●\e[0m",
  'blue'   => "\e[34m●\e[0m",
  'yellow' => "\e[33m●\e[0m",
  'purple' => "\e[35m●\e[0m",
  'orange' => "\e[38;5;208m●\e[0m",
  'empty'  => "○"
}.freeze

class Game
  def initialize(board)
    @board = board
  end

  def start
  end
end

class Player
end

class Board
  attr_accessor :holes
  def initialize(hole_count) # number of holes
    @holes = make_holes(hole_count.to_int)
  end

  def make_holes(holes)
    total_holes = []
    holes.times do
      total_holes << Hole.new('empty')
    end
    total_holes
  end
  
  Hole = Struct.new(:state) do 
    def update_state(state)
      self.state = COLORS.fetch(state)
    end
    
    def print
      
    end
  end
end

class Feedback
end
