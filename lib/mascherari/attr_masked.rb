module Mascherari
  module AttrMasked
    def attr_masked(attr, options = {})
      masked_attributes[attr] = Formatter.new options

      class_eval do
        define_method "#{attr}_masked" do
          self.class.masked_attributes[attr].mask send(attr)
        end

        define_method "#{attr}_unmasked" do
          self.class.masked_attributes[attr].unmask send(attr)
        end
      end
    end

    def masked_attributes
      @masked_attributes ||= {}
    end
  end
end
