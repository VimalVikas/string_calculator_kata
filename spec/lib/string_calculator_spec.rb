require 'rails_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    calculator = StringCalculator.new

    it 'returns 0 for an empty string' do
      expect(calculator.add('')).to eq(0)
    end

    context 'unknown amount of numbers' do
      it 'returns the number for a single number string' do
        expect(calculator.add('1')).to eq(1)
      end
      
      it 'returns the sum of two numbers separated by a comma' do
        expect(calculator.add('1,2')).to eq(3)
      end

      it 'returns the sum of an unknown amount of numbers' do
        expect(calculator.add('1,2,3')).to eq(6)
        expect(calculator.add('5,5,5,5')).to eq(20)
        expect(calculator.add('100')).to eq(100)
      end
    end

    it 'handles newlines as delimiters along with commas' do
      expect(calculator.add("1\n2,3")).to eq(6)
    end
  end
end
