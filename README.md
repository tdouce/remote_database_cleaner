# RemoteDatabaseCleaner

Clean database remotely. 

Integration testing SOA (Software Oriented Architecture) apps is an inherently 
difficult problem (Rails apps included :). SOA is comprised of multiple applications, 
and while individual apps can be tested (and presumably passing) in isolation (usually 
by mocking http requests), it does not guarantee the apps will work in unison. One
issue with integration testing SOA apps is that data, when created with 
tools such as [RemoteFactoryGirl](https://github.com/tdouce/remote_factory_girl),
persists across tests/specs. RemoteDatabaseCleaner, leveraging [DatabaseCleaner](https://github.com/bmabey/database_cleaner), provides a mechanism to clean the database remotely from the client. 

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
