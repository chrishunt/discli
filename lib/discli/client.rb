require 'discli/http_client'
require 'json'

module Discli
  class Client
    attr_reader :http_client

    DISCOGS_API = 'http://api.discogs.com:80'

    def initialize(http_client = HttpClient.new(DISCOGS_API))
      @http_client = http_client
    end

    def search(params)
      path     = '/database/search'
      params   = { :q => params } unless params.respond_to?(:keys)
      response = http_client.get(path, params)

      JSON.parse(response.body)['results']
    end
  end
end
