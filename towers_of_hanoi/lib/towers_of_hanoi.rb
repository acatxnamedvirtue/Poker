class TowersOfHanoi

  attr_accessor :towers

  def initialize(towers = [[3,2,1],[],[]])
    @towers = towers
  end

  def play
    until won?
      display_towers
      puts "Please enter a move: from_tower, to_tower"

      move(*get_input)
    end
  end

  def get_input
    begin
      gets.chomp.split(",").map{|tower| Integer(tower)}
    rescue StandardError => e
      puts "#{e}: Not a valid move, try again!"
      retry
    end
  end

  def display_towers
    system('clear')
    puts render
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

  def render
    'Tower 0:  ' + towers[0].join('  ') + "\n" +
    'Tower 1:  ' + towers[1].join('  ') + "\n" +
    'Tower 2:  ' + towers[2].join('  ') + "\n"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = TowersOfHanoi.new
  game.play
end
