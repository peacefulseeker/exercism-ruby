module Blackjack
  module Constants
    CARDS = [
      ACE = "ace",
      KING = "king",
      QUEEN = 'queen',
      JACK = 'jack',
      TWO = 'two',
      THREE = 'three',
      FOUR = 'four',
      FIVE = 'five',
      SIX = 'six',
      SEVEN = 'seven',
      EIGHT = 'eight',
      NINE = 'nine',
      TEN = 'ten',
      JOKER = 'joker',
    ].freeze

    DECISIONS = [
      STAND = "S",
      HIT = "H",
      SPLIT = "P",
      WIN = "W",
    ].freeze

    RANGES = [
      LOW = "low",
      MID = "mid",
      HIGH = "high",
      BLACKJACK = "blackjack",
    ].freeze
  end

  CARD_TO_VALUE = {
    Constants::JOKER => 0,
    Constants::TWO => 2,
    Constants::THREE => 3,
    Constants::FOUR => 4,
    Constants::FIVE => 5,
    Constants::SIX => 6,
    Constants::SEVEN => 7,
    Constants::EIGHT => 8,
    Constants::NINE => 9,
    Constants::TEN => 10,
    Constants::KING => 10,
    Constants::QUEEN => 10,
    Constants::JACK => 10,
    Constants::ACE => 11,
  }

  CARD_FALLBACK_VALUE = 0

  def self.parse_card(card)
    CARD_TO_VALUE.fetch(card, CARD_FALLBACK_VALUE)
  end

  def self.card_range(card1, card2)
    c1, c2 = parse_card(card1), parse_card(card2)
    score = c1 + c2

    case score
    when (4..11)
      Constants::LOW
    when (12..16)
      Constants::MID
    when (17..20)
      Constants::HIGH
    when 21
      Constants::BLACKJACK
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    c_range = card_range(card1, card2)

    # If you have a pair of aces you must always split them.
    if card1 == Constants::ACE and card2 == Constants::ACE
      Constants::SPLIT

    # If your cards sum up to 11 or lower you should always hit.
    elsif c_range == Constants::LOW
      Constants::HIT

    # If your cards sum up to a value within the range [12, 16]
    # you should always stand unless the dealer has a 7 or higher,
    # in which case you should always hit.
    elsif c_range == Constants::MID
      dc = parse_card(dealer_card)
      dc >= 7 ? Constants::HIT : Constants::STAND
    # If your cards sum up to a value within the range [17, 20]
    # you should always stand
    elsif c_range == Constants::HIGH
      Constants::STAND

    # If you have a Blackjack (two cards that sum up to a value of 21), and the dealer does not have an ace,
    # a figure or a ten then you automatically win. If the dealer does have any of those cards
    # then you'll have to stand and wait for the reveal of the other card.
    elsif c_range == Constants::BLACKJACK
      if not [Constants::TEN, Constants::ACE].include?(dealer_card)
        Constants::WIN
      else
        Constants::STAND
      end
    end
  end
end
