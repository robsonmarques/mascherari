class Person
  extend Mascherari::AttrMasked

  attr_accessor :phone

  attr_masked :phone, :format => "(##) ####-####"
end
