require 'card.rb'

describe Card do
  let(:ace_spades) {Card.new(:spades, :ace)}
  let(:queen_hearts) {Card.new(:hearts, :queen)}

  it "should only be one of four possible suits" do
    expect(Card.suits).to include(ace_spades.suit)
  end

  it "should only be value of 2 through Ace" do
    expect(Card.values).to include(ace_spades.value)
  end

  describe "#==" do
    let(:ace_spades2) {Card.new(:spades, :ace)}

    it "should compare cards using both suit and value"do
      expect(ace_spades).to eq(ace_spades2)
    end
  end

  describe "#to_s" do

    it "should return the card in string form" do
      expect(ace_spades.to_s).to eq("A♠")
    end
  end
end
