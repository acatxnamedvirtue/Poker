require_relative 'card'


class Deck

  def self.all_cards
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end
    deck
  end

  attr_accessor :cards

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def count
    cards.count
  end

  def take(n)
    taken = cards[0...n]
    self.cards = cards.drop(n)
    taken
  end

  def return(cards)
    self.cards.concat(cards)
  end
end
