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

    context 'different delimiters' do
      it 'handles newlines as delimiters along with commas' do
        expect(calculator.add("1\n2,3")).to eq(6)
      end

      it 'custom delimiter specified in //[delimiter]\\n format' do
        expect(calculator.add("//;\n1;2")).to eq(3)
        expect(calculator.add("//-\n4-5-6")).to eq(15)
      end

      context 'custom delimiters of any length' do
        it 'handles delimiters with multiple characters' do
          expect(calculator.add("//[***]\n1***2***3")).to eq(6)
          expect(calculator.add("//[abc]\n4abc5abc6")).to eq(15)
        end
      end

      context 'multiple delimiters' do
        it 'handles multiple delimiters' do
          expect(calculator.add("//[*][%]\n1*2%3")).to eq(6)
        end

        it 'handles multiple delimiters with longer than one character' do
          expect(calculator.add("//[**][%%]\n1**2%%3")).to eq(6)
        end
      end      
    end

    context 'negative numbers' do
      it 'raises an error when a negative number is included' do
        expect { calculator.add("1,-3") }.to raise_error(RuntimeError, /negatives not allowed: -3/)
        expect { calculator.add("1,-5,-7,3") }.to raise_error(RuntimeError, /negatives not allowed: -5, -7/)
      end
    end

    it 'ignores numbers greater than 1000' do
      expect(calculator.add("2,1001")).to eq(2)
      expect(calculator.add("1000,1")).to eq(1001)
      expect(calculator.add("1001,1002,3")).to eq(3)
    end
  end
end
