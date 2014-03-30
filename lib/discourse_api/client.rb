require 'faraday'
require 'faraday_middleware'
require 'json'
require 'discourse_api/version'
require 'discourse_api/api/categories'
require 'discourse_api/api/search'
require 'discourse_api/api/topics'
require 'discourse_api/api/users'

module DiscourseApi
  class Client
    attr_accessor :api_key, :api_username
    attr_reader :host

    include DiscourseApi::API::Categories
    include DiscourseApi::API::Search
    include DiscourseApi::API::Topics
    include DiscourseApi::API::Users

    def initialize(host, api_key=nil, api_username=nil)
      @host = host
      @api_key = api_key
      @api_username = api_username
    end

    def connection_options
      @connection_options ||= {
          url: @host,
          headers: {
              accept: 'application/json',
              user_agent: user_agent,
          }
      }
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def get(path, params={})
      request(:get, path, @api_key, @api_username, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    def user_agent
      @user_agent ||= "DiscourseAPI Ruby Gem #{DiscourseApi::VERSION}"
    end

    private

    def connection
      @connection ||= Faraday.new connection_options do |conn|
        # Convert request params to "www-form-encoded"
        conn.request :url_encoded
        # Parse responses as JSON
        conn.response :json
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
