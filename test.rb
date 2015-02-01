require "gosu"
include Gosu


class Game < Window
  WIDTH = 736
  HEIGHT = 414

  def initialize
 super HEIGHT, WIDTH, false
    self.caption = "TEST"
    @points = []
  end

  def update
    @points << [mouse_x, mouse_y]
  end

  def draw
    return if @points.empty?
    @points.inject(@points[0]) do |last|
      draw_line last[0], last[1], Color::GREEN

      point
    end
  end



end

Game.new.show