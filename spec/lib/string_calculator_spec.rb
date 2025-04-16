require 'rails_helper'

RSpec.describe StringCalculator do
  describe '#add' do
    calculator = StringCalculator.new

    it 'returns 0 for an empty string' do
      expect(calculator.add('')).to eq(0)
    end
  end
end
