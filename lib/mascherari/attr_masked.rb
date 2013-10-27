module Mascherari
  module AttrMasked
    def attr_masked(*attrs, options)
      attrs.each do |attr|
        class_eval %{
          def #{attr}_format
            @#{attr}_format ||= Formatter.new(#{options})
          end

          def #{attr}_masked
            #{attr}_format.mask #{attr}
          end

          def #{attr}_unmasked
            #{attr}_format.unmask #{attr}
          end
        }
      end
    end
  end
end
