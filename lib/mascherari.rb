require 'mascherari/version'
require 'mascherari/attr_masked'
require 'mascherari/formatter'

module Mascherari
  def self.included(base)
    base.extend AttrMasked
  end
end
