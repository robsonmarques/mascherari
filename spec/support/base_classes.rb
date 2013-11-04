class Person
  include Mascherari

  attr_accessor :phone, :mobile, :account

  attr_masked :phone, :mobile, :format => "(##) ####-####"
  attr_masked :account, :format => ["##.###-##", "###.###.###"]
end
