require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :board, :secret_code, :player
  def initialize(board = Board.new, player = Player.new)
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
      if (row.holes.map { |hole| hole.state } == secret_code)
        puts "You won!"
        return
      end
    end
    puts "You lost"
    puts "The correct code was #{secret_code}"
  end

  def set_code
    code = []
    board.length.times do
      code << COLORS.keys.sample
    end
    code
  end

  def feedback_sort(row)
    code = secret_code.dup
    guesses_sorted = []
    current_row = row.holes.map { |hole| hole.state }

    current_row.each_with_index do |color, index|
      if (color == code[index])
        guesses_sorted << 'match'
        code[index] = 'done'
        current_row[index] = 'done'
      end
    end

    current_row.each do |color|
      next if color == 'done'
      if (code.include?(color))
        guesses_sorted << 'exists'
        code[code.find_index(color)] = 'done' # order doesn't matter for this step
      end
    end
    
    while (guesses_sorted.length < 4)
      guesses_sorted << 'empty'
    end
    guesses_sorted
  end
end
