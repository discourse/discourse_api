require 'faraday'
require 'faraday_middleware'
require 'discourse_api/api/categories'
require 'discourse_api/api/topics'
require 'discourse_api/api/users'

module DiscourseApi
  class Client
    attr_reader :host, :port

    include DiscourseApi::API::Categories
    include DiscourseApi::API::Topics
    include DiscourseApi::API::Users

    def initialize(host, port=80, protocol='http')
      @host = host
      @port = port
      @protocol = protocol
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def get(path, params={})
      request(:get, path, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    private

    def connection
      @connection ||= Faraday.new(url: @host) do |conn|
        # Convert request params to "www-form-encoded"
        conn.request :url_encoded
        # Parse responses as JSON
        conn.response :json, :content_type => /\bjson$/
        # Use Faraday's default HTTP adapter
        conn.adapter Faraday.default_adapter
      end
    end

    def request(method, path, params={})
      response = connection.send(method.to_sym, path, params)
      response.env
    rescue Faraday::Error::ClientError, JSON::ParserError
      raise DiscourseApi::Error
    end
  end
end
