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
end
