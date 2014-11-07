require 'rubygems'
require 'bundler/setup'
# our gem
require 'remote_database_cleaner'

RSpec.configure do |config|

end

def configure_remote_database_cleaner(remote_name: nil,
                                      host: nil,
                                      port: nil,
                                      end_point: RemoteDatabaseCleaner::Config::DEFAULT_END_POINT,
                                      https: false)
  if remote_name.nil?
    RemoteDatabaseCleaner.configure do |config|
      config.home  = {:host      => host,
                      :port      => port,
                      :end_point => end_point }
      config.https = https
    end

  else
    RemoteDatabaseCleaner.configure(remote_name) do |config|
      config.home  = {:host      => host,
                      :port      => port,
                      :end_point => end_point }
      config.https  = https
    end
  end
end
