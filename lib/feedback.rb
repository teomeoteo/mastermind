require_relative 'row'

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
