require 'remote_database_cleaner/exceptions'

module RemoteDatabaseCleaner
  class Config

    attr_accessor :home, :https

    def initialize
      @home = default_home_config
      @https = false
    end

    def home_url
      raise_no_host_error
      http = 'http://'
      if home[:port]
        "#{ http }#{ home.fetch(:host) }:#{ home.fetch(:port) }#{ home.fetch(:end_point) }"
      else
        "#{ http }#{ home.fetch(:host) }#{ home.fetch(:end_point) }"
      end
    end

    def to_hash
      { home:     home,
        home_url: home_url }
    end

    def raise_no_host_error
      raise RemoteDatabaseCleanerConfigError.new("RemoteDatabaseCleaner.config.home[:host] can not be nil") unless has_home?
    end

    def has_home?
      !home[:host].nil? && !(home[:host] == '') && !home[:end_point].nil? && !(home[:end_point] == '')
    end

    private

    def default_home_config
      { :host      => nil,
        :port      => nil,
        :end_point => '/remote_database_cleaner/home/clean' }
    end
  end
end
