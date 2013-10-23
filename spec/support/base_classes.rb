class Person
  include Mascherari

  attr_accessor :phone, :mobile

  attr_masked :phone, :mobile, :format => "(##) ####-####"
end
