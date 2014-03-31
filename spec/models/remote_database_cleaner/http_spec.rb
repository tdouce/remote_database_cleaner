require 'remote_database_cleaner/http.rb'

describe RemoteDatabaseCleaner::Http do

  describe '.post' do

    let(:config) { double(:home_url => 'http://somewhere') }
    let(:params) { double(:first_name => 'Sam', :last_name => 'Iam') }
    let(:rest_client) { double('RestClient') }

    it 'should raise no host config errors' do
      rest_client.stub(:post).with(config.home_url, params, content_type: :json, accept: :json).and_return(true)
      expect(config).to receive(:raise_no_host_error) 
      RemoteDatabaseCleaner::Http.post(config, params, rest_client)
    end

    it 'should send http request to home_url with params' do
      config.stub(:raise_no_host_error)
      expect(rest_client).to receive(:post).with(config.home_url, params, content_type: :json, accept: :json) 
      RemoteDatabaseCleaner::Http.post(config, params, rest_client)
    end
  end
end
