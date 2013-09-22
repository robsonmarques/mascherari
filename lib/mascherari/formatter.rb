module Mascherari
  class Formatter
    attr_reader :format, :wild_card

    def initialize(options = {})
      @format = options.fetch :format
      @wild_card = options.fetch :wild_card, "#"
    end

    def mask(value)
      return value if formatted? value

      value_chars = value.chars

      format_chars do |char|
        wild_card?(char) ? value_chars.shift : char
      end
    end

    def unmask(value)
      return value unless formatted? value

      format_chars do |char, index|
        value[index] if wild_card?(char)
      end
    end

    protected

    def format_chars(&block)
      format.chars.map.with_index { |char, index| yield char, index }.join
    end

    def formatted?(value)
      value.size == format.size
    end

    def wild_card?(char)
      char == wild_card
    end
  end
end
