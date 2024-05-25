class Robot
  ALPHA = Array('A'..'Z')
  NUMS = Array(0..9)
  POSSIBLE_NAMES = ('AA000'..'ZZ999').to_a.shuffle.to_enum # interestingly, but that's faster then the one below
  # POSSIBLE_NAMES = ('AA000'..'ZZ999').to_enum

  # manual approach
  # POSSIBLE_NAMES = lambda do
  #   combs_letters = ALPHA.repeated_permutation(2)
  #   combs_nums = NUMS.repeated_permutation(3)
  #   combs_letters.each.with_object([]) do |letters, storage|
  #     combs_nums.each do |nums|
  #       storage.push(letters.join + nums.join)
  #     end
  #   end.to_enum
  # end.call

  def name
    @name ||= Robot::POSSIBLE_NAMES.next
  end

  def reset
    @name = nil
  end

  def self.forget
    Robot::POSSIBLE_NAMES.rewind
  end
end
