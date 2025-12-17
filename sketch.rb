class Game
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
      total_holes << Hole.new('empty', '')
    end
    total_holes
  end

  Hole = Struct.new(:state, :value) do 
    def update_value(data) # expects data = {value: x, state: x}
      self.value = data.fetch(:value) # throw exception if key not found (fetch)
    end

    def update_state(data)
      self.state = data.fetch(:state)
    end
  end
end

class Feedback
end
