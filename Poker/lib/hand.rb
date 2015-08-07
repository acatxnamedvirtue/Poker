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
    temp_cards = cards.dup

    pairs = []

    pairs << find_pair(cards) unless find_pair(cards).empty?

    pairs.each do |pair|
      pair.each do |card|
        temp_cards.delete(card)
      end
    end

    pairs << find_pair(temp_cards) unless find_pair(temp_cards).empty?

    pairs.count == 2
  end

  def one_pair?
    pair = []
    pair << find_pair(cards) unless find_pair(cards).empty?

    pair.count == 1
  end

  def high_card?
    true
  end

  def find_pair(cards)
    pair = []

    (0...cards.count).each do |idx|
      (idx...cards.count).each do |idy|
        pair += [cards[idx],cards[idy]] if  cards[idx].value == cards[idy].value && idx != idy && pair.empty?
      end
    end

    pair
  end
end
