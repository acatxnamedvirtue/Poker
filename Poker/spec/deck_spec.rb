require 'deck'
require 'card'

describe Deck do
  let(:all_cards) { Deck.all_cards }
  let(:deck) { Deck.new }
  let(:small_deck) { Deck.new([Card.new(:spades, :ace), Card.new(:spades, :deuce)])}
  describe "::all_cards" do


    it "should include all 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "should not have duplicates" do
      expect(all_cards.uniq.count).to eq(52)
    end
  end

  describe "#initialize" do

    it "should initialize with all the cards by default" do
      expect(Deck.new.count).to eq(52)
    end

    it "should initialize with a provided deck" do
      expect(small_deck.count).to eq(2)
    end
  end

  describe "#count" do

    it "should return the number of cards in the deck" do
      expect(all_cards.count).to eq(52)
      expect(small_deck.count).to eq(2)
    end
  end

  describe "#take" do
    let(:cards) { deck.cards.dup }
    it "should return the top n cards taken" do
      expect(deck.take(2)).to eq(all_cards[0...2])
    end

    it "should remove those cards from the deck" do
      deck.take(2)
      expect(deck.count).to eq(50)
    end
  end

  describe "#return" do

    it "should return given cards to the deck" do
      small_deck.return([Card.new(:spades, :queen)])
      expect(small_deck.count).to eq(3)
    end
  end
end
