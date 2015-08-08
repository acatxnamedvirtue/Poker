require_relative 'card'
require_relative 'deck'

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

  def beats?(other_hand)
    if hand_score > other_hand.hand_score
      true
    elsif hand_score < other_hand.hand_score
      false
    else
      
    end
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    card_hash.values.include?(4)
  end

  def full_house?
    card_hash.values.include?(3) && card_hash.values.include?(2)
  end

  def flush?
    Card.suits.each do |suit|
      return true if cards.all? { |card| card.suit == suit}
    end

    false
  end

  def straight?
    values = card_hash.keys.sort

    straights.each do |straight|
      return true if values == straight.sort
    end

    false
  end

  def three_of_a_kind?
    card_hash.values.include?(3)
  end

  def two_pair?
    card_hash.values.select{ |value| value == 2}.size == 2
  end

  def one_pair?
    card_hash.values.include?(2)
  end

  def high_card?
    true
  end

  def card_hash
    hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      hash[card.value] += 1
    end

    hash
  end

  def straights
    card_order = [:ace, :deuce, :three, :four, :five, :six, :seven, :eight, :nine,
      :ten, :jack, :queen, :king, :ace]

    straights = []

    idx, idy = 0, 4

    10.times do
      straights << card_order[idx..idy]
      idx += 1
      idy += 1
    end

    straights
  end

  def hand_score
    if straight_flush?
      9
    elsif four_of_a_kind?
      8
    elsif full_house?
      7
    elsif flush?
      6
    elsif straight?
      5
    elsif three_of_a_kind?
      4
    elsif two_pair?
      3
    elsif one_pair?
      2
    else
      1
    end
  end
end
