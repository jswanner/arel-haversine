# Arel::Haversine [![Build Status](https://secure.travis-ci.org/jswanner/arel-haversine.png?branch=master)](https://travis-ci.org/jswanner/arel-haversine)

Provides haversine formula, implemented with Arel.

## Installation

Add this line to your application's Gemfile:

    gem 'arel-haversine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arel-haversine

## Usage

``` ruby
require 'arel/haversine'

class Location < ActiveRecord::Base
  def self.in_order_of_proximity_to(latitude, longitude)
    order(
      Arel::Nodes::Haversine.new(
        arel_table[:latitude],
        arel_table[:longitude],
        latitude,
        longitude
      )
    )
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
