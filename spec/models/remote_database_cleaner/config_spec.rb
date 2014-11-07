require 'remote_database_cleaner/config'
require 'remote_database_cleaner/exceptions'

describe RemoteDatabaseCleaner::Config do

  let(:default_config) { RemoteDatabaseCleaner::Config.new }

  describe 'initialize' do

    describe 'default configuration' do
      it 'should be configured with correct defaults' do
        default_config = RemoteDatabaseCleaner::Config.new
        expect(default_config.home).to eq({ :host      => nil, 
                                            :port      => nil, 
                                            :end_point => '/remote_database_cleaner/home/clean'})
        expect(default_config.https).to eq(false)
      end
    end

    describe '#home_url' do
      it 'should return a url with port if port is configured' do
        default_config.home[:host] = 'localhost'
        default_config.home[:port] = 5555
        expect(default_config.home_url).to eq('http://localhost:5555/remote_database_cleaner/home/clean')
      end

      it 'should return a url without a port if port is not configured' do
        default_config.home[:host] = 'localhost_no_port'
        default_config.home[:port] = nil 
        expect(default_config.home_url).to eq('http://localhost_no_port/remote_database_cleaner/home/clean')
      end

      context 'configure https' do
        before do
          default_config.home[:host] = 'localhost'
          default_config.home[:port] = 5555
          default_config.https = true
        end

        it 'should be able configure Hyper Text Transfer Protocal Secure' do
          expect(default_config.https).to eq(true)
        end
      end
    end

    describe '#to_hash' do
      before do
        default_config.home[:host] = 'localhost'
      end

      it 'should return a hash representation' do
        expect(default_config.to_hash).to eq( {:home => {:host      => 'localhost',
                                                         :port      => nil,
                                                         :end_point => '/remote_database_cleaner/home/clean'},
                                               :home_url => 'http://localhost/remote_database_cleaner/home/clean' })
      end
    end

    describe 'errors' do
      it 'should raise RemoteDatabaseConfigError if .config.home[:host] is nil' do
        default_config.home[:host] = nil
        expect { default_config.to_hash }.to raise_error(RemoteDatabaseCleaner::RemoteDatabaseCleanerConfigError)
      end

      it 'should raise RemoteDatabaseConfigError if .config.home[:end_point] is nil' do
        default_config.home[:end_point] = nil
        expect { default_config.to_hash }.to raise_error(RemoteDatabaseCleaner::RemoteDatabaseCleanerConfigError)
      end
    end
  end
end
