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
      format_sub(wildcard) { |_, index| value[index] }
    end

    def remove_mask
      format_sub { |char, index| value[index] if wildcard?(char) }
    end

    def format_sub(pattern = /./, &block)
      format.gsub(pattern).each_with_index { |char, index| yield char, index }
    end

    def format_regexp
      /\A#{format_sub { |char| format_matcher char }}\z/
    end

    def format_matcher(char)
      wildcard?(char) ? '\S' : "\\#{char}"
    end

    def formatted?
      value =~ format_regexp
    end

    def wildcard?(char)
      char == wildcard
    end

    def valid_value?
      return true if formatted? || value.size == format.scan(wildcard).size

      raise ArgumentError, "Value size don't match format"
    end
  end
end
