class TowersOfHanoi

  attr_accessor :towers

  def initialize(towers = [[3,2,1],[],[]])
    @towers = towers
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

  def won?
    (towers[0].empty? && towers[1].empty?) || (towers[0].empty? && towers[2].empty?)
  end

  def render(disc)
    return " " if disc.nil?
    "X" * disc
  end
end
