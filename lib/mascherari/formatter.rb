module Mascherari
  class Formatter
    attr_reader :format, :wildcard

    def initialize(options = {})
      @format = options.fetch :format
      @wildcard = options.fetch :wildcard, "#"
    end

    def mask(value)
      return value if formatted? value

      value_chars = value.chars

      format_chars do |char|
        wildcard?(char) ? value_chars.shift : char
      end
    end

    def unmask(value)
      return value unless formatted? value

      format_chars do |char, index|
        value[index] if wildcard?(char)
      end
    end

    protected

    def format_chars(&block)
      format.chars.map.with_index { |char, index| yield char, index }.join
    end

    def formatted?(value)
      value.size == format.size
    end

    def wildcard?(char)
      char == wildcard
    end
  end
end
