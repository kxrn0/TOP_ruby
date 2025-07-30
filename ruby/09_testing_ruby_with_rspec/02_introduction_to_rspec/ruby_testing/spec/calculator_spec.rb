# frozen_string_literal: true

require './lib/calculator'

describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      calculator = Calculator.new

      expect(calculator.add(5, 2)).to eql(7)
    end

    it 'returns the sum of more than one number' do
      calculator = Calculator.new

      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#multiply' do
    it 'multiplies two numbers' do
      calculater = Calculator.new

      expect(calculater.multiply(5, 6)).to eql(30)
    end

    it 'multiplies three numbers' do
      calculater = Calculator.new

      expect(calculater.multiply(3, 4, 5)).to eql(60)
    end
  end
end
