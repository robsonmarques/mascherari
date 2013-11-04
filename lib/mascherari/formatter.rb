module Mascherari
  class Formatter
    def initialize(options = {})
      @format_list = Array(options.fetch :format)
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

    attr_reader :value, :format, :format_list, :wildcard

    def prepare_value(raw_value)
      @value = raw_value.to_s

      unless find_format
        raise ArgumentError, "Value size don't match format"
      end
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

    def wildcard_size?
      value.size == format.scan(wildcard).size
    end

    def wildcard?(char)
      char == wildcard
    end

    def find_format
      format_for { formatted? } || format_for { wildcard_size? }
    end

    def format_for(&block)
      format_list.any? { |format| @format = format; yield }
    end
  end
end
