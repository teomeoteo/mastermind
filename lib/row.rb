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
