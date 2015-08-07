require 'card'
require 'deck'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def draw(n, deck)
    cards.concat(deck.take(n))
  end

  def discard(discard_deck, card_indices)
    discard_cards = []

    card_indices.each do |idx|
      discard_cards << cards[idx]
    end

    discard_deck.return(discard_cards)

    discard_cards.each do |card|
      cards.delete(card)
    end

    nil
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
  end

  def full_house?
    three_of_a_kind? && one_pair?
  end

  def flush?
    Cards.suits.each do |suit|
      return true if cards.all? { |card| card.suit == suit}
    end

    false
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def one_pair?
    (0...cards.count).each do |idx|
      (idx...cards.count).each do |idy|
        return true if  cards[idx].value == cards[idy].value && idx != idy
      end
    end

    false
  end

  def high_card?
    true
  end
end
