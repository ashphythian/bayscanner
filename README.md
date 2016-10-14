# Bayscraper

This gem scrapes UK eBay given some search terms and search exclusion terms.
It is designed for obscure items which only occasionally appear within your price range.

It has two modes. One scrapes the site, and the other uses eBay's API.

The former can be used freely, however the latter requires an app_id from eBay's
developer site.

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
In both, the search terms are the only required parameter.

To scrape the site:
```
Bayscraper.search('search terms', exclusions: 'exclusion terms', min_price: min_price, min_price: max_price)
```

To use the API:
```
Bayscraper.final_results('search terms', exclusions: 'exclusion terms', min_price: min_price, max_price: max_price),
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bayscraper.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO

* Make namespacing clearer
* Sort out class input code smell (too many)
* Deal with items that have auction + BIN and with postage 'courier'
