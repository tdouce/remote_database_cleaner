require "remote_database_cleaner/version"
require 'remote_database_cleaner/config'
require 'remote_database_cleaner/http'

module RemoteDatabaseCleaner
  class RemoteDatabaseCleaner
    def params 
      { :database => :clean }
    end
  end

  def self.configure(opts = {:config => Config }, &block)
    configuration = opts.fetch(:config).new
    yield(configuration)
    self.config = configuration
  end

  def self.clean(http = Http)
    database_cleaner = RemoteDatabaseCleaner.new
    http.post(config, database_cleaner.params)
  end

  def self.config
    @config
  end

  def self.config=(config)
    @config = config
  end

  def self.reset(config = Config.new)
    self.config = config
  end
end
