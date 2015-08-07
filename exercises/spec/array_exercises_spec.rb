require 'array_exercises'

describe Array do

  describe "#my_uniq" do
    let(:arr) {[1,2,3,3,4,4,5]}
    it "should return an array" do
      expect(arr.my_uniq).to be_kind_of(Array)
    end

    it "should return only unique values" do
      expect(arr.my_uniq).to eq(arr.uniq)
    end

    it "should not modify the original array" do
      expect(arr.my_uniq).not_to eq(arr)
    end

    it "should not use the built in Array#uniq method" do
      expect(arr).to_not receive(:uniq)
    end
  end

  describe "#two_sum" do
    let(:arr) { [-1, 0, 2, -2, 1] }

    it "should return an array" do
      expect(arr.two_sum).to be_kind_of(Array)
    end

    it "should not modify the original array" do
      expect(arr.two_sum).not_to eq(arr)
    end

    it "should return element tuples that sum to zero" do
      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end

    it "should not contain duplicates" do
      expect(arr.two_sum).not_to eq([[0, 4], [2, 3], [4, 0], [3, 2]])
    end

    it "should not contain pairs of the same index" do
      expect(arr.two_sum).not_to include([1,1])
    end

    it "should return sorted elements" do
      expect(arr.two_sum).not_to eq([[2, 3], [0, 4]])
    end

  end

  describe "#my_transpose" do
    let(:arr1) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:arr2) { [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15]]}
    let(:trans_arr1) { [[0, 3, 6], [1, 4, 7], [2, 5, 8]] }
    let(:trans_arr2) { [[0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15]]}

    it "should return an array" do
      expect(arr1.my_transpose).to be_kind_of(Array)
    end

    it "should not modify the original array" do
      expect(arr1.my_transpose).not_to eq(arr1)
    end

    it "should transpose square matricies of any size" do
      expect(arr1.my_transpose).to eq(trans_arr1)
      expect(arr2.my_transpose).to eq(trans_arr2)
    end

    it "should not use the built in Array#transpose method" do
      expect(arr1).to_not receive(:transpose)
    end

  end

  describe "#stock_picker" do
    let(:arr) { [12, 14, 17, 20, 45, 32, 28, 26, 32] }

    it "should return an array" do
      expect(stock_picker(arr)).to be_kind_of(Array)
    end

    it "should return an array of two elements" do
      expect(stock_picker(arr).count).to eq(2)
    end

    it "should return a sorted pair" do
      expect(stock_picker(arr)[0]).to be < stock_picker(arr)[1]
    end

    it "should return the most profitable pair of days" do
      expect(stock_picker(arr)).to eq([0, 4])
    end
  end
end
