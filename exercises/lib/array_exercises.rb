class Array
  def my_uniq
    uniq_arr = []

    self.each do |el|
      uniq_arr << el unless uniq_arr.include?(el)
    end

    uniq_arr
  end

  def two_sum
    new_array = []

    self.each_with_index do |xl, idx|
      self.each_with_index do |yl, idy|
        new_array << [idx, idy] if (xl + yl == 0) && idx != idy && idy>idx
      end
    end
    new_array
  end

  def my_transpose
    temp_arr = self.dup
    trans_arr = []

    temp_arr.size.times do
      col = []

      temp_arr.each do |row|
        col << row.shift
      end

      trans_arr << col
    end

    trans_arr
  end
end

def stock_picker(array)
  max = 0
  days = [0,0]

  (0...array.count).each do |buy_idx|
    ((buy_idx)...array.count).each do |sell_idx|
      if array[sell_idx] - array[buy_idx] > max
        max = array[sell_idx] - array[buy_idx]
        days[0], days[1] = buy_idx, sell_idx
      end
    end
  end

  return days
end
