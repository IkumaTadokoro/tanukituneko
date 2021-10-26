require_relative './dice.rb'

class Game
  attr_reader :point
  def initialize
    @result = play
    @point = 0
  end
  
  def play
    results = 6.times.map do
      Dice.new
    end
    results.map(&:roll).join
  end

  def judge
    judge_results = if tanukituneko?
      ["たぬきつねこ (点数)1000",1000]
    elsif nukoneko?
      ["ぬこねこ (点数)600",600]
    elsif kituneko?
      ["きつねこ (点数)400",400]
    elsif tanukitu?
      ["たぬきつ (点数)400",400]
    elsif kitune?
      ["きつね (点数)200",200]
    elsif tanuki?
      ["たぬき (点数)200",200]
    elsif nuko?
      ["ぬこ (点数)150",150]
    elsif neko?
      ["ねこ (点数)100",100]
    else
      [" (点数)0",0]
    end
    @point += judge_results[1]
	puts "(出た目)#{@result} （成立した役）#{judge_results[0]}"
  end

#   private

  def nuko?
    /ぬ/.match?(@result) && /こ/.match?(@result)
  end

  def neko?
    /ね/.match?(@result) && /こ/.match?(@result)
  end

  def nukoneko?
    nuko? && neko? && @result.chars.select { |str| str == 'こ' }.size >= 2
  end

  def tanuki?
    /た/.match?(@result) && /ぬ/.match?(@result) && /き/.match?(@result)
  end

  def kitune?
    /き/.match?(@result) && /つ/.match?(@result) && /ね/.match?(@result)
  end
  
  def tanukitu?
    tanuki? && /ね/.match?(@result)
  end

  def kituneko?
    kitune? && neko?
  end

  def tanukituneko?
    tanuki? && kitune? && neko?
  end
end

rocal_point = 0
5.times do
  game = Game.new
  puts game.judge
  rocal_point += game.point
end

puts rocal_point
