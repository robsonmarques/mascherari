module Mascherari
  module AttrMasked
    def attr_masked(*attrs, options)
      attrs.each do |attr|
        formatter = "#{attr}_format"
        masked    = "#{attr}_masked"
        unmasked  = "#{attr}_unmasked"
        ivar      = "@#{formatter}"

        define_method formatter do
          instance_variable_get(ivar) || instance_variable_set(ivar, Formatter.new(options))
        end

        define_method masked do
          send(formatter).mask send(attr)
        end

        define_method unmasked do
          send(formatter).unmask send(attr)
        end
      end
    end
  end
end
