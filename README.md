# Mascherari

[![Build Status](https://travis-ci.org/robsonmarques/mascherari.png)](https://travis-ci.org/robsonmarques/mascherari)
[![Code Climate](https://codeclimate.com/github/robsonmarques/mascherari.png)](https://codeclimate.com/github/robsonmarques/mascherari)

An easy way to handle masks. (Work in progress)

## Installation

Simple as:

    $ gem install mascherari

## Usage

To create masks for attributes, include Mascherari and set the format:

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
# person.mobile = "5599213035"
person.phone_masked
=> "(55) 5421-2035"
person.mobile_masked
=> "(55) 9921-3035"

# person.phone = "(55) 5421-2035"
# person.mobile = "(55) 9921-3035"
person.phone_unmasked
=> "5554212035"
person.mobile_unmasked
=> "5599213035"
```

## Rails

Add this line to your application's Gemfile:

    gem 'mascherari'

And then execute:

    $ bundle

You can include Mascherari in Rails models as:

```ruby
# config/initializers/mascherari.rb
ActiveSupport.on_load :active_record do
  include Mascherari
end

# app/models/person.rb
class Person < ActiveRecord::Base
  attr_masked :phone, :format => "(##) ####-####"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
