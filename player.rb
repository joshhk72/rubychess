require_relative 'display'

class Player
  attr_reader :color

  def initialize(color, display)
    @color = color
    @display = display
  end

end

class HumanPlayer < Player
  def initialize(color, display)
    super(color, display)
  end

  def make_move
    move = display.cursor.get_input
  end

  private

  attr_reader :display
end