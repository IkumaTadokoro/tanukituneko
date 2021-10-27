require_relative 'turn'

class Game
  def initialize(game_count)
    @game_count = game_count
    @results = Array.new(@game_count).map { |_n| Turn.new }
  end

  def play = [@results.flat_map(&:score), "合計得点： #{@results.map(&:point).sum}点"].join("\n")
end

puts Game.new(5).play
