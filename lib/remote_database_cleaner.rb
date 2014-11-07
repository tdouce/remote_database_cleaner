require "remote_database_cleaner/version"
require 'remote_database_cleaner/config'
require 'remote_database_cleaner/http'
require 'remote_database_cleaner/remotes_config'

module RemoteDatabaseCleaner
  class RemoteDatabaseCleaner
    def params
      { :database => :clean }
    end
  end

  def self.configure(remote_name = remotes_config.default_remote_name, opts = {:config => Config }, &block)
    configuration = opts.fetch(:config).new
    yield(configuration)
    remotes_config.remotes[remote_name] = configuration
  end

  def self.clean(http = Http)
    database_cleaner = RemoteDatabaseCleaner.new
    config_for_remote = config(remotes_config.current_remote)
    http.post(config_for_remote, database_cleaner.params)
  end

  def self.with_remote(remote_name = remotes_config.default_remote_name)
    remotes_config.current_remote = remote_name
    self
  end

  def self.remotes_config
    @remotes_config ||= RemotesConfig.new
  end

  def self.config(remote_name = remotes_config.default_remote_name)
    remotes_config.remotes[remote_name]
  end
end
