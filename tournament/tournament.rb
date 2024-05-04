require 'ostruct'

class Tournament
  module Constants
    RESULT = [
      LOSS = 'loss',
      DRAW = 'draw',
      WIN = 'win'
    ].freeze
  end

  def initialize
    @teams = {}
  end

  def self.tally(input)
    new.tally(input.split(/\n/))
  end

  def tally(rows)
    rows.each do |row|
      team1_name, team2_name, result = row.split(';')

      teams[team1_name] ||= Team.new(team1_name)
      teams[team2_name] ||= Team.new(team2_name)

      case result
      when Constants::LOSS
        teams[team1_name].losses += 1
        teams[team2_name].wins += 1
      when Constants::WIN
        teams[team1_name].wins += 1
        teams[team2_name].losses += 1
      when Constants::DRAW
        teams[team1_name].draws += 1
        teams[team2_name].draws += 1
      end
    end

    render_results
  end

  private

  attr_reader :teams

  def header
    "Team                           | MP |  W |  D |  L |  P\n"
  end

  def teams_sorted
    teams.values.sort_by { |team| [-team.points, team.name] }
  end

  def rows
    teams_sorted.map(&method(:row)).join
  end

  def row(team)
    <<~RESULTS
      #{team.name.ljust(30)} | \
      #{team.matches.to_s.rjust(2)} | \
      #{team.wins.to_s.rjust(2)} | \
      #{team.draws.to_s.rjust(2)} | \
      #{team.losses.to_s.rjust(2)} | \
      #{team.points.to_s.rjust(2)}
    RESULTS
  end

  def render_results
    header + rows
  end
end

class Team
  attr_accessor :wins, :losses, :draws
  attr_reader :name

  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @draws = 0
  end

  def points
    wins * 3 + draws
  end

  # each match can have only 1 result, hence can just sum up
  def matches
    wins + losses + draws
  end
end
