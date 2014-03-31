require 'remote_database_cleaner'

describe RemoteDatabaseCleaner do
  it 'should return params for http request' do
    rfg = RemoteDatabaseCleaner::RemoteDatabaseCleaner.new
    expect(rfg.params).to eq({ :database => :clean })
  end

  it 'should be able to configure with a block' do
    pending
  end

  describe '.config' do
    it 'should be able to set and get config' do
      config = double('config')
      RemoteDatabaseCleaner.config = config
      expect(RemoteDatabaseCleaner.config).to equal(config)
    end
  end

  describe '.reset' do
    it 'should be able to reset the configuration' do
      config = double('config')
      RemoteDatabaseCleaner.config = config
      RemoteDatabaseCleaner.reset(double('config'))
      expect(RemoteDatabaseCleaner.config).to_not equal(config)
    end
  end

  describe '.clean' do
    it 'should send http request and parse request' do
      config = double('config', :home_url => 'http://somewhere', :to_hash => {})
      http   = double('RemoteDatabaseCleanerFriends::Http', :post => {})
      RemoteDatabaseCleaner.config = config
      expect(http).to receive(:post).with(config, { :database => :clean })
      RemoteDatabaseCleaner.clean(http)
    end
  end
end
