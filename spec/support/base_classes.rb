class Person
  extend Mascherari::AttrMasked

  attr_accessor :phone, :mobile

  attr_masked :phone, :mobile, :format => "(##) ####-####"
end
