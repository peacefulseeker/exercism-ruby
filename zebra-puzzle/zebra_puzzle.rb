class ZebraPuzzle
  # think how to transform constranints to actual code
  # guided by: https://kevinbinz.com/2017/08/01/satisfiability-zebra-puzzle/
  # The Englishman lives in the red house. N1 = C1
  # The Spaniard owns the dog. N2 = P1
  # Coffee is drunk in the green house. D1 = C2
  # The Ukrainian drinks tea. N3 = D2
  # The green house is immediately to the right of the ivory house. C3 = Hx +1
  # The Old Gold smoker owns snails. S1 = P2
  # Kools are smoked in the yellow house. S2 = C5
  # Milk is drunk in the middle house. D3 = H3
  # The Norwegian lives in the first house. N4 = H1
  # The man who smokes Chesterfields lives in the house next to the man with the fox. S3 = Hx & P3 = Hx +- 1
  # Kools are smoked in the house next to the house where the horse is kept. S3 = Hx & P4 = Hx +- 1
  # The Lucky Strike smoker drinks orange juice. S4 = D4
  # The Japanese smokes Parliaments. N5 = S5
  # The Norwegian lives next to the blue house.  N4 = Hx & C5

  def self.water_drinker
    'Norwegian'
  end

  def self.zebra_owner
    'Japanese'
  end
end
