require_relative 'feedback'
require_relative 'row'

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
