# Mascherari

An easy way to handle masks. (Work in progress)

## Installation

Add this line to your application's Gemfile:

    gem 'mascherari'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mascherari

## Usage

To create masks for your attributes, extend Mascherari::AttrMasked to your class and set the format:

```ruby
class Person
  extend Mascherari::AttrMasked

  attr_accessor :phone

  attr_masked :phone, :format => "(##) ####-####"
end
```

You can also extend Mascherari::AttrMasked to your Rails models:

```ruby
# config/initializers/mascherari.rb
ActiveSupport.on_load :active_record do
  extend Mascherari::AttrMasked
end

# app/models/person.rb
class Person < ActiveRecord::Base
  attr_masked :phone, :format => "(##) ####-####"
end
```

That will give you two methods to use along with your objects:

```ruby
# person.phone = "555412035"
person.phone_masked
=> "(55) 5421-2035"

# person.phone = "(55) 5421-2035"
person.phone_unmasked
=> "555412035"
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
