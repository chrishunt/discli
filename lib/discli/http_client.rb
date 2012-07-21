require 'net/http'
require 'uri'

module Discli
  class HttpClient
    attr_reader :host, :client

    def initialize(host)
      @host   = URI.parse(host)
      @client = Net::HTTP.new(@host.host, @host.port)
    end

    def get(path, params = {})
      url = host.path + path + encode(params)
      client.get(url, headers)
    end

    private

    def encode(params)
      return '' unless params.size > 0

      '?' + params.map do |k, v|
        "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}"
      end.join('&')
    end

    def headers
      {
        'User-Agent'   => 'discli/0.1 +https://github.com/huntca/discli',
        'Content-Type' => 'application/json'
      }
    end
  end
end
