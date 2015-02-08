require 'gosu'
include Gosu

class ScoreCard
  def initialize(window)
    @window = window
    @font = Font.new(window, 'Arial', 30)
  end

  def draw(players)
    @font.draw("#{players.map(&:score).join(' :: ')}", Game::WIDTH/2, 20, 0)
  end
end

class Ball
  attr_accessor :x, :y

  def initialize(window)
    @window = window
    @initial_x = Game::WIDTH/2
    @initial_y = Game::HEIGHT/2
    reset
    @vx = 10 #ball speed on x axix
    @vy = 1
  end

  def update
    @x += @vx
    @y += @vy
    if @y > Game::HEIGHT || @y < 0
      @vy *= -1
    elsif @x > Game::WIDTH
      @vx *= -1
    end
  end

  def draw
    @window.draw_quad(
        @x-5, @y-5, Color::WHITE,
        @x+5, @y-5, Color::WHITE,
        @x+5, @y+5, Color::WHITE,
        @x-5, @y+5, Color::WHITE,
    )
  end

  def switch_direction(place_on_paddle)
    @vx *= -1
    @vy = place_on_paddle / 10

  end

  def switch_direction_slightly(place_on_paddle)
    @vx *= -1
    @vy = (place_on_paddle / 10) + 1
  end


  def reset
    @x = @initial_x
    @y = @initial_y
  end
end

class Player
  attr_accessor :x, :y, :score
  WIDTH = 10
  HEIGHT = 80

  def initialize(window, x, y)
    @window = window
    @initial_x = x
    @initial_y = y
    @x = x
    @y = y
    @score = 0
  end

  def update
  end

  def move_up
    @y -= 12
    @y = [HEIGHT/2, @y].max
  end

  def move_down
    @y += 12
    @y = [Game::HEIGHT - HEIGHT/2, @y].min
  end

  def move_slightly
    @y += 1
    @y = [Game::HEIGHT - HEIGHT/2, @y].min
  end

  def hits?(ball)
    (@x - ball.x).abs < 5 && (@y - ball.y).abs < 50
  end

  def increment_score
    @score += 1
  end

  def draw
    @window.draw_quad(
        @x-WIDTH/2, @y-HEIGHT/2, Color::WHITE,
        @x+WIDTH/2, @y-HEIGHT/2, Color::WHITE,
        @x+WIDTH/2, @y+HEIGHT/2, Color::WHITE,
        @x-WIDTH/2, @y+HEIGHT/2, Color::WHITE,
    )
  end

  def reset
    @x = @initial_x
    @y = @initial_y
  end

end

class Game < Window
  WIDTH = 1200
  HEIGHT = 800

  def initialize
    super(WIDTH, HEIGHT, true)
    @ball = Ball.new(self)
    @player_1 = Player.new(self, 40, HEIGHT/2)
    @player_2 = Player.new(self, 0, HEIGHT/2)
    @players = [@player_1, @player_2]
    @score_card = ScoreCard.new(self)
    @state = :in_play
    @container = []
    @container2 = []
  end


  def needs_cursor?
    false
  end

  def update
    @container.flatten!
    @container.slice! -10..-1
    @container << mouse_y * 10000
     p @container

    if @state == :in_play


        case when @container.count >= 1
        if @container[-1].to_i < @container[-2].to_i || @container[-1].to_i == 0
        @player_1.move_up


        elsif @container[-1].to_i > @container[-2].to_i || @container[-1].to_i == 7991111
        @player_1.move_down

      end
      end


        if @player_1.hits?(@ball)

          @container2 << @player_1.y
          @container2.slice! -50..-1
          p @container2
=begin
          case when @container2.count == 0
                 @ball.switch_direction(@ball.y - @player_1.y)
                 @player_1.increment_score
          end

          case when @container2.count == 1
                 @ball.switch_direction(@ball.y - @player_1.y)
                 @player_1.increment_score
          end
=end
          case when
                 if @container2[-1] == @container2[-2]
                   @ball.switch_direction_slightly(@ball.y  - @player_1.y)
                   #@player_1.move_slightly

                 else
                   @ball.switch_direction(@ball.y - @player_1.y)
                   @player_1.increment_score
                 end

          end

        end


      if @ball.x < 0
        @player_2.increment_score
        @state = :stopped
      end

      @ball.update
    elsif @state == :stopped
      if button_down?(KbSpace)
        @players.each(&:reset)
        @ball.reset
        @state = :in_play
      end
    end
  end

  def draw
    @score_card.draw(@players)
    @ball.draw
    @player_1.draw
    #@player_2.draw
  end


end
Game.new.show
