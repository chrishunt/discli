require 'discli/http_client'

describe Discli::HttpClient do
  let(:client)   { Discli::HttpClient.new('http://example.com') }
  let(:net_http) { double(:net_http) }
  let(:headers) {{
    'User-Agent'   => 'discli/0.1 +https://github.com/huntca/discli',
    'Content-Type' => 'application/json' }}

  before do
    Net::HTTP.stub(:new => net_http)
  end

  describe '#get' do
    it 'encodes url parameters' do
      net_http.should_receive(:get).
        with('awesome-api?p1=param%20one&p2=paramTwo', headers)

      client.get('awesome-api',{
        :p1 => 'param one',
        :p2 => 'paramTwo' })
    end
  end
end
