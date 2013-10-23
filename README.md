# Mascherari

An easy way to handle masks. (Work in progress)

## Installation

Simple as:

    $ gem install mascherari

## Usage

To create masks for your attributes, include Mascherari in your class and set the format:

```ruby
class Person
  include Mascherari

  attr_accessor :phone, :mobile

  attr_masked :phone, :mobile, :format => "(##) ####-####"
end
```

That will give you two helpers for each attribute:

```ruby
# person.phone = "5554212035"
person.phone_masked
=> "(55) 5421-2035"

# person.phone = "(55) 5421-2035"
person.phone_unmasked
=> "5554212035"

# person.mobile = "5599213035"
person.mobile_masked
=> "(55) 9921-3035"

# person.mobile = "(55) 9921-3035"
person.mobile_unmasked
=> "5599213035"
```

You can also use the stand alone Formatter to create formats and apply as you want:

```ruby
phone_format = Mascherari::Formatter.new :format => "(##) ####-####"

phone_format.mask "555412035"
=> "(55) 5421-2035"

phone_format.unmask "(99) 3343-1205"
=> "9933431205"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
