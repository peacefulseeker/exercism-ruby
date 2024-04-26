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

    RANGE = {
      4..11 => LOW,
      12..16 => MID,
      17..20 => HIGH,
      21..21 => BLACKJACK,
    }

  end

  CARD = {
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

  CARD.default = 0

  def self.two_aces?(card1, card2)
    [card1, card2].all?(Constants::ACE)
  end

  def self.parse_card(card)
    CARD[card]
  end

  def self.card_range(card1, card2)
    c1, c2 = parse_card(card1), parse_card(card2)
    score = c1 + c2
    Constants::RANGE.select { |range, _| range.cover?(score) }.values.first
  end

  def self.first_turn(card1, card2, dealer_card)
    c_range = card_range(card1, card2)
    dealer_card_score = parse_card(dealer_card)

    # If you have a pair of aces you must always split them.
    return Constants::SPLIT if two_aces?(card1, card2)

    # If your cards sum up to 11 or lower you should always hit.
    return Constants::HIT if c_range == Constants::LOW
    # If your cards sum up to a value within the range [17, 20]
    # you should always stand
    return Constants::STAND if c_range == Constants::HIGH

    # If your cards sum up to a value within the range [12, 16]
    # you should always stand unless the dealer has a 7 or higher,
    # in which case you should always hit.
    if c_range == Constants::MID
      dealer_card_score >= 7 ? Constants::HIT : Constants::STAND

    # If you have a Blackjack (two cards that sum up to a value of 21), and the dealer does not have an ace,
    # a figure or a ten then you automatically win. If the dealer does have any of those cards
    # then you'll have to stand and wait for the reveal of the other card.
    elsif c_range == Constants::BLACKJACK
      dealer_card_score < 10 ?  Constants::WIN : Constants::STAND
    end
  end
end
