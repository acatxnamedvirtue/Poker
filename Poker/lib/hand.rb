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

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    card_hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      card_hash[card.value] += 1
    end

    card_hash.values.include?(4)
  end

  def full_house?
    card_hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      card_hash[card.value] += 1
    end

    card_hash.values.include?(3) && card_hash.values.include?(2)
  end

  def flush?
    Card.suits.each do |suit|
      return true if cards.all? { |card| card.suit == suit}
    end

    false
  end

  def straight?
  end

  def three_of_a_kind?
    card_hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      card_hash[card.value] += 1
    end

    card_hash.values.include?(3)
  end

  def two_pair?
    card_hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      card_hash[card.value] += 1
    end

    card_hash.values.select{ |value| value == 2}.size == 2
  end

  def one_pair?
    card_hash = Hash.new{|h,k| h[k] = 0}

    cards.each do |card|
      card_hash[card.value] += 1
    end

    card_hash.values.include?(2)
  end

  def high_card?
    true
  end
end
