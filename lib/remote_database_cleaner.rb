require "remote_database_cleaner/version"
require 'remote_database_cleaner/config'
require 'remote_database_cleaner/http'
require 'remote_database_cleaner/config_struct'

module RemoteDatabaseCleaner
  class RemoteDatabaseCleaner
    def params 
      { :database => :clean }
    end
  end

  def self.configure(opts = { :config_struct => ConfigStruct, :config => Config }, &block)
    config      = opts.fetch(:config_struct).block_to_hash(block)
    self.config = opts.fetch(:config).configure(config)
  end

  def self.clean(http = Http)
    database_cleaner  = RemoteDatabaseCleaner.new
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
