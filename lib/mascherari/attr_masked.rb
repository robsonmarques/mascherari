module Mascherari
  module AttrMasked
    def attr_masked(*attrs, options)
      attrs.each do |attr|
        format = "#{attr}_format"
        masked = "#{attr}_masked"
        unmasked = "#{attr}_unmasked"

        define_method format do
          @format ||= Formatter.new options
        end

        define_method masked do
          send(format).mask send(attr)
        end

        define_method unmasked do
          send(format).unmask send(attr)
        end
      end
    end
  end
end
