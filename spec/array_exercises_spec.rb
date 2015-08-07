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

  describe "#my_trasnpose" do
    let(:arr) = { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }

    it "should return an array" do
      expect(arr.two_sum).to be_kind_of(Array)
    end

    it "should not modify the original array"

    it "should transpose square matricies of any size"

  end
end
