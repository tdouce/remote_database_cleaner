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
  end

  describe '.clean' do
    it 'should send http request and parse request' do
      http = double('RemoteDatabaseCleaner::Http')
      expect(http).to receive(:post)
      RemoteDatabaseCleaner.clean(http)
    end
  end
end
