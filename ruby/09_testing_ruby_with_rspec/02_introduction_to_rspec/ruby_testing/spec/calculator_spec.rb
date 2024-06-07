require "./lib/calculator"

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#multiply" do
    it "multiplies numbers togheter" do
      calculator = Calculator.new
      expect(calculator.multiply(1, 2, 3, 4, 5)).to eql(120)
    end
  end

  describe "#substract" do
    it "substracts two numbers" do
      calculator = Calculator.new
      expect(calculator.substract(10, 5)).to eql(5)
    end
  end
end
