require 'discli'

describe Discli::Client do
  let(:http_client) { stub.as_null_object }
  let(:client)      { Discli::Client.new(http_client) }

  describe '#search' do
    let(:path)   { '/database/search' }
    let(:artist) { 'miles davis' }
    let(:params) {{ :q => artist }}

    it 'searches for single terms' do
      http_client.should_receive(:get).with(path, params).
        and_return(double(:response, :body => '{"results": []}'))

      client.search(artist)
    end

    it 'returns the search results' do
      http_client.should_receive(:get).with(path, params).
        and_return(double(:response, :body => <<-JSON
          { "results": [
            { "album": "album 1" },
            { "album": "album 2" } ]}
        JSON
        ))

      results = client.search(artist)
      results.should == [
          { 'album' => 'album 1' },
          { 'album' => 'album 2' } ]
    end

    context 'with search parameters' do
      let(:params) {{ :artist => artist }}

      it 'passes search parameters to the discogs api' do
        http_client.should_receive(:get).with(path, params).
          and_return(double(:response, :body => '{"results": []}'))

        client.search(params)
      end
    end
  end
end
