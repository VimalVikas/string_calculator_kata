class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    numbers, delimiter = extract_delimiter_and_numbers(numbers)
    numbers_array = split_numbers(numbers, delimiter)

    check_for_negatives(numbers_array)

    numbers_array.sum
  end

  private

  def extract_delimiter_and_numbers(numbers)
    default_delimiter = /,|\n/
  
    # Check if we have a custom delimiter
    if numbers.start_with?('//')
      header, numbers = numbers.split("\n", 2)
  
      # Multiple delimiters case
      if header.match?(/\A\/\/\[(.+)\]\z/)
        custom_delim = header.scan(/\[(.+?)\]/).flatten.map { |d| Regexp.escape(d) }.join('|')
        [numbers, custom_delim]
      else
        # Single delimiter case
        custom_delim = Regexp.escape(header[2..])
        [numbers, custom_delim]
      end
    else
      [numbers, default_delimiter]
    end
  end

  def split_numbers(numbers, delimiter)
    numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
  end  

  def check_for_negatives(numbers_array)
    negatives = numbers_array.select { |n| n < 0 }
    raise "negatives not allowed: #{negatives.join(', ')}" if negatives.any?
  end
end
