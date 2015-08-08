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
  end

  describe "#beats?(other_hand)" do
    let(:hand) { Hand.new }
    let(:other_hand) { Hand.new }

    it "should return true if our hand is a better category than other hand" do
      hand.cards = [
        Card.new(:hearts, :ace),
        Card.new(:hearts, :deuce),
        Card.new(:hearts, :three),
        Card.new(:hearts, :five),
        Card.new(:hearts, :four)
      ]
      other_hand.cards = [
        Card.new(:hearts, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:diamonds, :deuce),
        Card.new(:clubs, :three),
        Card.new(:spades, :three)
      ]

      expect(hand.beats?(other_hand)).to be true
    end

    it "should return false if the other hand is a better category than our hand" do
      other_hand.cards = [
        Card.new(:hearts, :ace),
        Card.new(:hearts, :deuce),
        Card.new(:hearts, :three),
        Card.new(:hearts, :five),
        Card.new(:hearts, :four)
      ]
      hand.cards = [
        Card.new(:hearts, :deuce),
        Card.new(:spades, :deuce),
        Card.new(:diamonds, :deuce),
        Card.new(:clubs, :three),
        Card.new(:spades, :three)
      ]

      expect(hand.beats?(other_hand)).to be false
    end

    it "should return true if the categories are the same and we have the higher cards" do
      other_hand.cards = [
        Card.new(:hearts, :ace),
        Card.new(:hearts, :deuce),
        Card.new(:hearts, :three),
        Card.new(:hearts, :five),
        Card.new(:hearts, :four)
      ]
      hand.cards = [
        Card.new(:hearts, :six),
        Card.new(:hearts, :seven),
        Card.new(:hearts, :eight),
        Card.new(:hearts, :nine),
        Card.new(:hearts, :ten)
      ]

      expect(hand.beats?(other_hand)).to be true
    end

    it "should return false if the categories are the same and they have the higher cards" do
      hand.cards = [
        Card.new(:hearts, :ace),
        Card.new(:hearts, :deuce),
        Card.new(:hearts, :three),
        Card.new(:hearts, :five),
        Card.new(:hearts, :four)
      ]
      other_hand.cards = [
        Card.new(:hearts, :six),
        Card.new(:hearts, :seven),
        Card.new(:hearts, :eight),
        Card.new(:hearts, :nine),
        Card.new(:hearts, :ten)
      ]

      expect(hand.beats?(other_hand)).to be false
    end
  end

  describe "Hand Categories" do

    describe "#one_pair?" do
      let(:hand) { Hand.new }

      it "should return true if the hand has a pair" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :deuce),
          Card.new(:diamonds, :four),
          Card.new(:clubs, :five),
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

    describe "#two_pair?" do
      let(:hand) { Hand.new }

      it "should return true if the hand has two pairs" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :deuce),
          Card.new(:diamonds, :three),
          Card.new(:clubs, :four),
          Card.new(:spades, :three)
        ]

        expect(hand.two_pair?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.two_pair?).to be false
      end
    end

    describe "#three_of_a_kind?" do
      let(:hand) { Hand.new }

      it "should return true if the hand has 3 cards of the same value" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :deuce),
          Card.new(:diamonds, :deuce),
          Card.new(:clubs, :three),
          Card.new(:spades, :three)
        ]
        expect(hand.three_of_a_kind?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.three_of_a_kind?).to be false
      end
    end

    describe "#straight?" do
      let(:hand) { Hand.new }

      it "should return true if the hand has 5 cards in a row" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :three),
          Card.new(:diamonds, :four),
          Card.new(:clubs, :six),
          Card.new(:spades, :five)
        ]
        expect(hand.straight?).to be true
      end

      it "should treat ace as high and also low" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :three),
          Card.new(:diamonds, :four),
          Card.new(:clubs, :ace),
          Card.new(:spades, :five)
        ]
        expect(hand.straight?).to be true

        hand.cards = [
          Card.new(:hearts, :ten),
          Card.new(:spades, :queen),
          Card.new(:diamonds, :jack),
          Card.new(:clubs, :king),
          Card.new(:spades, :ace)
        ]
        expect(hand.straight?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.straight?).to be false
      end
    end

    describe "#flush?" do
      let(:hand) { Hand.new }

      it "should return true if the hand is all the same suit" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:hearts, :four),
          Card.new(:hearts, :ten),
          Card.new(:hearts, :king),
          Card.new(:hearts, :three)
        ]
        expect(hand.flush?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.flush?).to be false
      end
    end

    describe "#full_house?" do
      let(:hand) { Hand.new }

      it "should return true if the hand is a three of a kind and a pair" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :deuce),
          Card.new(:diamonds, :deuce),
          Card.new(:hearts, :king),
          Card.new(:diamonds, :king)
        ]
        expect(hand.full_house?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.full_house?).to be false
      end
    end

    describe "#four_of_a_kind?" do
      let(:hand) { Hand.new }

      it "should return true if the hand has 4 cards of the same value" do
        hand.cards = [
          Card.new(:hearts, :deuce),
          Card.new(:spades, :deuce),
          Card.new(:diamonds, :deuce),
          Card.new(:clubs, :deuce),
          Card.new(:spades, :three)
        ]
        expect(hand.four_of_a_kind?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.four_of_a_kind?).to be false
      end
    end

    describe "#straight_flush?" do
      let(:hand) { Hand.new }

      it "should return true if the hand is a straight and a flush" do
        hand.cards = [
          Card.new(:hearts, :ace),
          Card.new(:hearts, :deuce),
          Card.new(:hearts, :three),
          Card.new(:hearts, :five),
          Card.new(:hearts, :four)
        ]
        expect(hand.straight_flush?).to be true
      end

      it "should return false otherwise" do
        hand.cards = [
            Card.new(:hearts, :deuce),
            Card.new(:spades, :four),
            Card.new(:diamonds, :five),
            Card.new(:clubs, :nine),
            Card.new(:spades, :three)
        ]
        expect(hand.straight_flush?).to be false
      end
    end
  end
end
