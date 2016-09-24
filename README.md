# Bayscraper

This gem scrapes UK eBay given some search terms and search exclusion terms.
It is designed for obscure items which only occasionally appear within your price range.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bayscraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bayscraper

## Usage

Bayscraper.search('search terms', 'exclusion terms', min_price, max_price)
max_price).search
TODO

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bayscraper.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO

* Add specs
* Add item name (doh!)
* Deal with items that have auction + BIN
* Use price range as actual filter
