require 'remote_database_cleaner'

describe RemoteDatabaseCleaner do

  before { RemoteDatabaseCleaner.reset }

  describe 'configuration' do
    it 'should be configured with correct defaults' do
      expect(RemoteDatabaseCleaner.config.home).to eq({:host      => nil, 
                                                       :port      => nil, 
                                                       :end_point => 'remote_database_cleaners'})
    end

    it 'should be able to configure with a block' do
      RemoteDatabaseCleaner.configure do |config|
        config.home = { host: 'tifton' }
      end
      expect(RemoteDatabaseCleaner.config.home[:host]).to eq('tifton')
    end

    it 'should be able to configure .home' do
      RemoteDatabaseCleaner.config.home[:host] = 'fun_guy'
      RemoteDatabaseCleaner.config.home[:port] = 3333 
      RemoteDatabaseCleaner.config.home[:end_point] = '/down_home' 
      expect(RemoteDatabaseCleaner.config.home[:host]).to eq('fun_guy')
      expect(RemoteDatabaseCleaner.config.home[:port]).to eq(3333)
      expect(RemoteDatabaseCleaner.config.home[:end_point]).to eq('/down_home')
    end
  end

  describe 'errors' do
    it 'should raise RemoteDatabaseCleanerConfigError if .config.home[:host] is nil' do
      RemoteDatabaseCleaner.config.home[:host] = nil
      expect { RemoteDatabaseCleaner.clean }.to raise_error(RemoteDatabaseCleaner::RemoteDatabaseCleanerConfigError)
    end

    it 'should raise RemoteDatabaseCleanerConfigError if .config.home[:end_point] is nil' do
      RemoteDatabaseCleaner.config.home[:end_point] = nil
      expect { RemoteDatabaseCleaner.clean }.to raise_error(RemoteDatabaseCleaner::RemoteDatabaseCleanerConfigError)
    end
  end

  describe '.clean' do
    it 'should send a post request to home' do
      RemoteDatabaseCleaner::Http.stub(:post).and_return(true)
      RemoteDatabaseCleaner.config.home[:host] = 'localhost'
      config = RemoteDatabaseCleaner.config
      params = { :database => :clean }
      expect(RemoteDatabaseCleaner::Http).to receive(:post).with(config, params) 
      RemoteDatabaseCleaner.clean
    end
  end
end
