require 'ostruct'

class Tournament
  module Constants
    RESULT = [
      LOSS = 'loss',
      DRAW = 'draw',
      WIN = 'win'
    ].freeze
  end

  RESULT_TO_POINTS = {
    Constants::WIN => 3,
    Constants::DRAW => 1,
    Constants::LOSS => 0
  }.freeze

  RESULT_TO_POINTS_FOR_TEAM2 = {
    Constants::WIN => RESULT_TO_POINTS[Constants::LOSS],
    Constants::DRAW => RESULT_TO_POINTS[Constants::DRAW],
    Constants::LOSS => RESULT_TO_POINTS[Constants::WIN]
  }.freeze

  def initialize
    @teams = {}
  end

  def self.tally(input)
    new.tally(input)
  end

  def tally(input)
    rows = input.split(/\n/)
    rows.each do |row|
      team1_name, team2_name, result = row.split(';')

      team1 = get_or_create_team(team1_name)
      team2 = get_or_create_team(team2_name)

      # TODO: make dry / optimal
      team1.matches += 1
      team1.draws += result == Constants::DRAW ? 1 : 0
      team1.points += RESULT_TO_POINTS[result]
      team1.wins += result == Constants::WIN ? 1 : 0
      team1.losses += result == Constants::LOSS ? 1 : 0

      team2.matches += 1
      team2.draws += result == Constants::DRAW ? 1 : 0
      team2.points += RESULT_TO_POINTS_FOR_TEAM2[result]
      team2.wins += result == Constants::LOSS ? 1 : 0
      team2.losses += result == Constants::WIN ? 1 : 0
    end

    # TODO: sort in place?
    teams_sorted = teams.sort_by { |name, result| [-result.points, name] }.to_h

    result = "#{'Team'.ljust(30)} | MP |  W |  D |  L |  P\n"
    teams_sorted.each do |team|
      result << <<~RESULTS
        #{team[0].ljust(30)} | \
        #{team[1].matches.to_s.rjust(2)} | \
        #{team[1].wins.to_s.rjust(2)} | \
        #{team[1].draws.to_s.rjust(2)} | \
        #{team[1].losses.to_s.rjust(2)} | \
        #{team[1].points.to_s.rjust(2)}
      RESULTS
    end

    result
  end

  private

  attr_reader :teams

  def get_or_create_team(name)
    return teams[name] if teams.key?(name)

    teams[name] = OpenStruct.new({
                                   points: 0,
                                   matches: 0,
                                   wins: 0,
                                   losses: 0,
                                   draws: 0
                                 })
    teams[name]
  end
end
