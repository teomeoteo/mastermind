COLORS = {
  'red'    => "\e[31m●\e[0m",
  'green'  => "\e[32m●\e[0m",
  'blue'   => "\e[38;5;21m●\e[0m",
  'yellow' => "\e[33m●\e[0m",
  'purple' => "\e[38;5;57m●\e[0m",
  'orange' => "\e[38;5;208m●\e[0m",
}.freeze

class Game
  attr_accessor :board, :secret_code, :player
  def initialize(board, player = Player.new)
    @board = board
    @secret_code = set_code
    @player = player
  end

  def start
    board.rows[0].pointer = true
    board.render
    board.rows.each do |row|
      row.pointer = true
      board.length.times do |i|
        puts "Enter a color"
        puts "(red, green, blue, yellow, purple orange)"
        print "\n"
        color = player.input
        row.holes[i].update_state(color)
        print ("\n")
        board.feedback.holes[i].state = row.holes[i].state
        board.render
      end
      board.feedback.pointer = true
      board.feedback.check_holes(secret_code)
      print "\n"
      board.render
      row.pointer = false
    end
  end

  def set_code
    COLORS.keys.sample(board.rows[0].holes.length)
  end

  def check
  end
end

class Player
  def input
    color = ''
    loop do
      color = gets.chomp.to_s.downcase
      if (COLORS.keys.include?(color))
        break
      else
        puts "Invalid color"
      end
    end
    color
  end
end

class Row
  attr_accessor :holes, :pointer
  def initialize(hole_count) # number of holes
    @holes = make(hole_count.to_int)
    @pointer = false
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
    if (pointer)
      print " <---"
      print " Colors: "
      COLORS.each do |color, value|
        print value + " "
      end
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
      elsif (self.state == 'match')
        print "\e[97m●\e[0m "
      elsif (self.state == 'exists')
        print "\e[97m◎\e[0m "
      else
        print "#{COLORS[self.state]} "
      end
    end
  end
end

class Board
  attr_accessor :rows, :feedback, :length
  def initialize(feedback = Feedback.new(4))
    @rows = make
    @feedback = feedback
    @length = feedback.holes.length
  end
  def render
    feedback.render
    rows.each do |row|
      row.render
    end
  end

  def make
    Array.new(12) {Row.new(4)}
  end
end

class Feedback < Row
  attr_accessor :holes, :pointer
  def initialize(hole_count)
    @holes = make(hole_count.to_int)
    @pointer = false
  end
  def render
    holes.each do |hole|
      hole.render
    end
    if (pointer)
      print " <---"
    end
    print "\n"
    puts "-------"
  end

  def check_holes(code)
    holes.each_with_index do |hole, index|
      if (hole.state == code[index])
        hole.update_state('match')
      elsif (code.include?(hole.state))
        hole.update_state('exists')
      else
        hole.update_state('empty')
      end
    end
  end
end

game = Game.new(Board.new)
# game.board.render
feedback = Feedback.new(4)
p game.secret_code
game.start
