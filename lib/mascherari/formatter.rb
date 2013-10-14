module Mascherari
  class Formatter
    attr_reader :format, :wildcard

    def initialize(options = {})
      @format = options.fetch :format
      @wildcard = options.fetch :wildcard, "#"
    end

    def mask(raw_value)
      prepare_value raw_value

      formatted? ? value : add_mask
    end

    def unmask(raw_value)
      prepare_value raw_value

      formatted? ? remove_mask : value
    end

    protected

    attr_reader :value

    def prepare_value(raw_value)
      @value = raw_value.to_s

      valid_value?
    end

    def add_mask
      value_chars = value.chars

      format_chars do |char|
        wildcard?(char) ? value_chars.shift : char
      end
    end

    def remove_mask
      format_chars do |char, index|
        value[index] if wildcard?(char)
      end
    end

    def format_chars(&block)
      format.chars.map.with_index { |char, index| yield char, index }.join
    end

    def formatted?
      value.size == format.size
    end

    def wildcard?(char)
      char == wildcard
    end

    def valid_value?
      unless formatted? || value.size == format.scan(wildcard).size
        raise ArgumentError, "Value size don't match format"
      end
    end
  end
end
