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
    else # card category is same
      if straight_flush?
        rank(highest_card_straights) > other_hand.rank(other_hand.highest_card_straights)
      elsif four_of_a_kind?
        rank(card_hash.invert[4]) > other_hand.rank(other_hand.card_hash.invert[4])
      elsif full_house?

      elsif flush?

      elsif straight?
        rank(highest_card_straights) > other_hand.rank(other_hand.highest_card_straights)
      elsif three_of_a_kind?
        rank(card_hash.invert[3]) > other_hand.rank(other_hand.card_hash.invert[3])
      elsif two_pair?
        if rank(highest_pair) > other_hand.rank(other_hand.highest_pair)
          true
        elsif rank(highest_pair) > other_hand.rank(other_hand.highest_pair)
          false
        else
          temp_hand = Hand.new
          temp_other_hand = Hand.new
          hand.cards.each { |card| temp_hand.cards << card unless card.value == highest_pair }
          other_hand.cards.each { |card| temp_other_hand.cards << card unless card.value == other_hand.highest_pair }

          if temp_hand.rank(temp_hand.highest_pair) > temp_other_hand.rank(temp_other_hand.highest_pair)
            true
          elsif temp_hand.rank(temp_hand.highest_pair) > temp_other_hand.rank(temp_other_hand.highest_pair)
            false
          else
            final_card = Hand.new
            other_final_card = Hand.new
            temp_hand.cards.each { |card| final_card.cards << card unless card.value == temp_hand.highest_pair}
            temp_other_hand.cards.each { |card| other_final_card.cards << card unless card.value == temp_other_hand.highest_pair}

            if final_card.rank(final_card.cards.first) > other_final_card.rank(other_final_card.cards.first)
              true
            elsif final_card.rank(final_card.cards.first) > other_final_card.rank(other_final_card.cards.first)
              false
            else
              nil
            end
          end
        end
      elsif one_pair?
        if rank(highest_pair) > other_hand.rank(other_hand.highest_pair)
          true
        elsif rank(highest_pair) > other_hand.rank(other_hand.highest_pair)
          false
        else
          temp_hand = Hand.new
          temp_other_hand = Hand.new
          hand.cards.each {|card| temp_hand.cards << card unless card.value == hand.highest_pair}
          other_hand.cards.each {|card| temp_other_hand.cards << card unless card.value == other_hand.highest_pair}

          if temp_hand.rank(temp_hand.highest_card) > temp_other_hand.rank(temp_other_hand.highest_card)
            true
          elsif temp_hand.rank(temp_hand.highest_card) > temp_other_hand.rank(temp_other_hand.highest_card)
            false
          else
            temp_hand2 = Hand.new
            temp_other_hand2 = Hand.new
            temp_hand.cards.each {|card| temp_hand2.cards << card unless card.value == temp_hand.highest_pair}
            temp_other_hand.cards.each {|card| temp_other_hand2.cards << card unless card.value == temp_other_hand.highest_pair}

            if temp_hand2.rank(temp_hand2.highest_card) > temp_other_hand2.rank(temp_other_hand2.highest_card)
              true
            elsif temp_hand2.rank(temp_hand2.highest_card) > temp_other_hand2.rank(temp_other_hand2.highest_card)
              false
            else
              final_card = Hand.new
              other_final_card = Hand.new
              temp_hand2.cards.each {|card| final_card.cards << card unless card.value == temp_hand2.highest_pair}
              temp_other_hand2.cards.each {|card| other_final_card.cards << card unless card.value == temp_other_hand2.highest_pair}

              if final_card.rank(final_card.highest_card) > other_final_card.rank(other_final_card.highest_card)
                true
              elsif final_card.rank(final_card.highest_card) > other_final_card.rank(other_final_card.highest_card)
                false
              else
                nil
              end
            end
          end
        end
      elsif high_card?
        our_hand = hand.dup
        their_hand = other_hand.dup

        until our_hand.empty? && their_hand.empty?
          if our_hand.highest_card > their_hand.highest_card
            true
          elsif our_hand.highest_card > their_hand.highest_card
            false
          else
            our_highest_card_idx
            their_highest_card_idx
            our_hand.cards.each_with_index {|card, idx| our_highest_card_idx = idx if card.value == our_hand.highest_card }
            their_hand.cards.each_with_index {|card, idx| their_highest_card_idx = idx if card.value == their_hand.highest_card }
            our_hand.delete_at(our_highest_card_idx)
            their_hand.delete_at(their_highest_card_idx)
          end
        end
      end
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
    else # high card
      1
    end
  end

  def highest_card_straights
    if card_hash.include?(:ace) && card_hash.include?(:king)
      :ace
    else
      highest_card_index = 0

      card_hash.keys.each do |card_value|
        if card_order.index(card_value) > highest_card_index
          highest_card_index = card_order.index(card_value)
        end
      end

      card_order[highest_card_index]
    end
  end

  def highest_pair
    if card_hash.include?(:ace) && card_hash[:ace] == 2
      :ace
    else
      highest_pair = ""
      highest_pair_rank = 0

      card_hash.keys.each do |card_value|
        if card_hash[card_value] == 2 && rank(card_value) > highest_pair_rank
          highest_pair = card_value
          highest_pair_rank = rank(card_value)
        end
      end
      highest_pair
    end
  end

  def rank(card_value)
    if card_value == :ace
      13
    else
      card_order.index(card_value)
    end
  end

  def highest_card
    if card_hash.include?(:ace)
      :ace
    else
      highest_card = ""
      highest_card_rank = 0

      card_hash.keys.each do |card_value|
        if rank(card_value) > highest_card_rank
          highest_card = card_value
          highest_card_rank = rank(card_value)
        end
      end

      highest_card
    end
  end

  def card_order
    [:ace, :deuce, :three, :four, :five, :six, :seven, :eight, :nine,
      :ten, :jack, :queen, :king, :ace]
  end
end
