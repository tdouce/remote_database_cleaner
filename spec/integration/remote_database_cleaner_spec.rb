require 'remote_database_cleaner'
require 'spec_helper'

describe RemoteDatabaseCleaner do

  before { RemoteDatabaseCleaner.remotes_config.reset }

  describe 'configuration' do
    it 'should be configured with correct defaults' do
      expect(RemoteDatabaseCleaner.config.home).to eq({:host      => nil,
                                                       :port      => nil,
                                                       :end_point => '/remote_database_cleaner/home/clean'})

      expect(RemoteDatabaseCleaner.config.https).to eq(false)
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

    describe '#home_url' do
      context 'when configured to with http' do
        before do
          RemoteDatabaseCleaner.config.home[:host] = 'localhost'
        end

        it 'should use http' do
          expect(
            RemoteDatabaseCleaner.config.home_url
          ).to eq('http://localhost/remote_database_cleaner/home/clean')
        end
      end

      context 'when configured to with https' do
        before do
          RemoteDatabaseCleaner.config.https = true
        end

        it 'should use https' do
          RemoteDatabaseCleaner.config.home[:host] = 'localhost'

          expect(
            RemoteDatabaseCleaner.config.home_url
          ).to eq('https://localhost/remote_database_cleaner/home/clean')
        end
      end
    end

    context 'when configuring multiple remotes' do
      before do
        configure_remote_database_cleaner(remote_name: :travis,
                                          host: 'localhost',
                                          port: 3000,
                                          end_point: '/remote_factory_girl/travis/home')
        configure_remote_database_cleaner(remote_name: :casey,
                                          host: 'over_the_rainbow',
                                          port: 6000,
                                          end_point: '/remote_factory_girl/casey/home')
      end

      it 'should return configuration for remote "travis"' do
        expect(RemoteDatabaseCleaner.config(:travis).home).to eq({:host      => 'localhost',
                                                                  :port      => 3000,
                                                                  :end_point => '/remote_factory_girl/travis/home'})
      end

      it 'should return configuration for remote "casey"' do
        expect(RemoteDatabaseCleaner.config(:casey).home).to eq({:host      => 'over_the_rainbow',
                                                                 :port      => 6000,
                                                                 :end_point => '/remote_factory_girl/casey/home'})
      end
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
    context 'when remote is not configured by name' do
      before do
        configure_remote_database_cleaner(host: 'localhost')
      end

      it 'should be configured to send http requests to default home' do
        config = RemoteDatabaseCleaner.config
        params = { :database => :clean }
        expect(RemoteDatabaseCleaner::Http).to receive(:post).with(config, params)
        RemoteDatabaseCleaner.clean
      end

      it 'should be configured to send HTTP requests to default home' do
        http = double('http')

        expect(http).to receive(:post) do |config, params, rest_client|
          expect(config.home_url).to eq('http://localhost/remote_database_cleaner/home/clean')
        end

        RemoteDatabaseCleaner.clean(http)
      end
    end
  end
end
