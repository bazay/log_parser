# LogParser

This respository was created to provide a solution to the coding task outlined in `./TASK.md`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_parser

## Usage

This gem can be re-used across various projects that require log parsing. This can be achieved through adding the gem in your gemfile then requiring it where necessary.

This will expose the `LogParser::Parser` class which is the primary class containing logic.

For example:

```ruby
require 'log_parser'

path_to_log_file = './files/webserver.log'
parser = LogParser::Parser.new(path_to_log_file)
# Then parse the provided file, populating parser.log_items
parser.parse
log_items = parser.log_items
# => [<LogItem path: '/home', ip_address: '127.0.0.1' >, ...]
```

To perform sorting of log items, two methods are exposed on `LogParser::LogItem` class.

```ruby
# 1. Sort by page views
LogParser::LogItem.sort_by_page_views(log_items)
# => { '/home' => [<LogItem path: '/home', ip_address: '127.0.0.1', ...] }

# 2. Sort by unique page views
LogParser::LogItem.sort_by_unique_views(log_items)
# => { '/contact' => [<LogItem path: '/contact', ip_address: '127.0.0.1', ...] }
```

The above methods return hashes in order from most to least, where the keys are the webpage and the values are an array of log items that match that path. In the case of unique views the array does not contain duplicate values.

A basic CLI script utilizing these classes has been provided under the `bin/` directory and can be used to demonstrate the program:

    ./bin/run PATH_TO_FILE

Where `PATH_TO_FILE` should be where the log file is located on disk.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

Test are written in RSpec and exist under the `spec/` directory.

They can be run as follows:

    bundle exec rspec spec/

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bazay/log_parser.
