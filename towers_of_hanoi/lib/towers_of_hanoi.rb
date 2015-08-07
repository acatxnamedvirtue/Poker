class TowersOfHanoi

  attr_accessor :towers

  def initialize
    @towers = [[3,2,1], [], []]
  end

  def move(start_tower, end_tower)
    if towers[start_tower].empty?
      raise "Illegal Move: no disc"
    end

    if !towers[start_tower].empty? && !towers[end_tower].empty? &&
      towers[start_tower].last > towers[end_tower].last
      raise "Illegal Move: Disc being moved is larger than target tower disc"
    end

    towers[end_tower] << towers[start_tower].pop
  end
end
