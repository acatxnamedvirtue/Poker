require 'hand'
require 'card'
require 'deck'

describe Hand do
  describe "#initialize" do
    let(:empty_hand) { Hand.new }


    it "should initialize with no cards" do
      expect(empty_hand.cards.empty?).to be true
    end

  end

  describe "#draw" do
    let(:empty_hand) { Hand.new }

    it "should take cards from the deck" do
      deck_cards = [
        Card.new(:hearts, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:diamonds, :deuce),
        Card.new(:clubs, :deuce),
        Card.new(:spades, :three)
      ]
      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      empty_hand.draw(5,deck)
      expect(empty_hand.cards.count).to eq(5)
    end

  end

  describe "#discard" do
    let(:hand) { Hand.new }

    it "removes card(s) from your hand and puts them into discard deck" do
      deck_cards = [
        Card.new(:hearts, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:diamonds, :deuce),
        Card.new(:clubs, :deuce),
        Card.new(:spades, :three)
      ]
      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)
      discard_deck = double("discard_deck")
      expect(discard_deck).to receive(:return).with([deck_cards[0], deck_cards[2], deck_cards[3]])

      hand.draw(5, deck)
      hand.discard(discard_deck, [0,2,3])

      expect(hand.cards.count).to eq(2)
    end

    describe "Hand Categories" do

      describe "#one_pair?" do
        let(:hand) { Hand.new }

        it "should return true if the hand has a pair" do
          hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :deuce),
            Card.new(:diamonds, :deuce),
            Card.new(:clubs, :deuce),
            Card.new(:spades, :three)
          ]

          expect(hand.one_pair?).to be true
        end

        it "should return false otherwise" do
          hand.cards = [
              Card.new(:hearts, :deuce),
              Card.new(:spades, :four),
              Card.new(:diamonds, :five),
              Card.new(:clubs, :nine),
              Card.new(:spades, :three)
          ]
          expect(hand.one_pair?).to be false
        end
      end

    end
  end



end
