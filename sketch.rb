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

  # input for current row
  def get_input(row)
    board.feedback.pointer = false
    num = row.holes.length
    Array.new(num) do |i|
      color = player.input
      row.holes[i].update_state(color)
      print ("\n")
      if (i == num - 1)
        board.feedback.pointer = true
        sorted_guesses = feedback_sort(row)
        board.feedback.holes.each_with_index do |hole, index|
          hole.update_state(sorted_guesses[index])
        end
      end
      p secret_code
      board.render
    end
  end

  def start
    board.rows[0].pointer = true # starting row
    board.render
    board.rows.each do |row|
      row.pointer = true
      get_input(row)
      row.pointer = false
    end
  end

  def set_code
    code = []
    board.length.times do
      code << COLORS.keys.sample
    end
    code
  end

  def feedback_sort(row)
    current_row = row.holes.map { |hole| hole.state }
    code = secret_code.dup
    guess_exists = 0
    valid_exists_count = 0
    p code
    
    guesses = row.holes.map { |hole| hole.state }.map.with_index do |color, index|
      if (code.include?(color))
        if (color == code[index])
          code[index] = 'done'
          'match'
        else
          guess_exists += 1
          'exists'
        end
      else
        'empty'
      end
    end

    valid_exists = current_row.map do |color|
      if (code.include?(color))
        code[code.find_index(color)] = 'done'
        valid_exists_count += 1
        'exists'
      else
        'empty'
      end
    end
    
    exists_for_deletion = guess_exists - valid_exists_count
    while (exists_for_deletion > 0)
      guesses[guesses.find_index('exists')] = 'empty'
      exists_for_deletion -= 1
    end

    p guesses
    p valid_exists
  
    sorted_guesses = []

    guesses.each do |color|
      if (color == 'exists')
        sorted_guesses << color
      elsif (color == 'match')
        sorted_guesses.unshift(color)
      end
    end

    guesses.each do |color|
      if (color == 'empty')
        sorted_guesses << color
      end
    end

    sorted_guesses
  end
end

class Player
  def input
    puts "Enter a color"
    puts "(red, green, blue, yellow, purple, orange)"
    print "\n"
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
    end
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
      print "\n"
    end
  end

  def make
    Array.new(12) {Row.new(4)}
  end
end

class Feedback < Row
  def render
    holes.each do |hole|
      hole.render
    end
    if (pointer)
      print " <--- Feedback"
    end
    print "\n"
    puts "-------"
  end
end

game = Game.new(Board.new)
# game.board.render
game.start
