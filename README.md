# RemoteDatabaseCleaner

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:


```ruby
group :test do
  gem 'remote_factory_girl'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install remote_database_cleaner

## Usage

Configure in `spec/spec_helper.rb`

```ruby
RemoteDatabaseCleaner.configure do |config|
  config.home = { host: 'localhost', port: 5000, end_point: "/over_the_rainbow" }
end

RSpec.configure do |config|
  config.after(:each) do
    RemoteDatabaseCleaner.clean
  end
end
```

## Run Tests 
    $ rspec

## Contributing

1. Fork it ( http://github.com/<my-github-username>/remote_database_cleaner/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
