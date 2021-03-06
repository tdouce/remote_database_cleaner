require 'rubygems'
require 'bundler/setup'
require 'remote_database_cleaner'

RSpec.configure do |config|
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

def configure_remote_database_cleaner(
  remote_name: nil, host: nil, port: nil,
  end_point: RemoteDatabaseCleaner::Config::DEFAULT_END_POINT, https: false
)
  if remote_name.nil?
    RemoteDatabaseCleaner.configure do |config|
      config.home = {
        host: host,
        port: port,
        end_point: end_point
      }
      config.https = https
    end
  else
    RemoteDatabaseCleaner.configure(remote_name) do |config|
      config.home = {
        host: host,
        port: port,
        end_point: end_point
      }
      config.https = https
    end
  end
end
