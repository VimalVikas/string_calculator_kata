class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    delimiter = /,|\n/
    
    if numbers.start_with?('//')
      parts = numbers.split("\n", 2)
      custom_delim = parts[0][2..] # extract after '//'
      numbers = parts[1]
      delimiter = Regexp.escape(custom_delim)
    end

    numbers.split(/#{delimiter}/).map(&:to_i).sum
  end
end
