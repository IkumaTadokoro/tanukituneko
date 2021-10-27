require_relative 'dice'

class Turn
  ROLE_TABLE = {
    'たぬきつねこ' => 1000,
    'きたきつね' => 800,
    'ぬこねこ' => 600,
    'きつねこ' => 400,
    'たぬきつ' => 400,
    'たぬき' => 200,
    'きつね' => 200,
    'ぬこ' => 150,
    'ねこ' => 100
  }.freeze

  attr_reader :point

  def initialize
    @results = Array.new(6).map { |_n| Dice.new.roll }
    @role = judge_role.keys.join
    @point = judge_role.values.join.to_i
  end

  def score = "（出た目）#{@results.join} (成立した役) #{@role} （点数） #{@point}"

  private

  def judge_role
    candidate_roles = tallied_roles.select(&method(:appear?))
    candidate_roles.empty? ? { '' => 0 } : max_point_role_of(candidate_roles)
  end

  def max_point_role_of(candidate_roles)
    ROLE_TABLE.select { |key, value| key.chars.tally == candidate_roles.first[0] }
  end

  def tallied_roles = ROLE_TABLE.map { |key, value| [key.chars.tally, value] }

  def appear?(tallied_role)
    # resultsをすべて負に変換してから足し合わせるので、正の数が出現するのは、役に対して文字が足りない（つまり役が成立しない）時
    tallied_role[0].merge(negative_value_results) { |key, role_value, results_value| role_value + results_value }
                   .none? { |key, value| value.positive? }
  end

  def negative_value_results = @results.tally.transform_values { |value| value * -1 }
end
