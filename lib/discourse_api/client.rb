require 'faraday'
require 'faraday_middleware'
require 'json'
require 'uri'
require 'discourse_api/version'
require 'discourse_api/api/categories'
require 'discourse_api/api/search'
require 'discourse_api/api/sso'
require 'discourse_api/api/tags'
require 'discourse_api/api/topics'
require 'discourse_api/api/posts'
require 'discourse_api/api/users'
require 'discourse_api/api/groups'
require 'discourse_api/api/invite'
require 'discourse_api/api/private_messages'
require 'discourse_api/api/notifications'
require 'discourse_api/api/badges'
require 'discourse_api/api/email'
require 'discourse_api/api/api_key'
require 'discourse_api/api/backups'
require 'discourse_api/api/dashboard'
require 'discourse_api/api/uploads'
require 'discourse_api/api/user_actions'
require 'discourse_api/api/site_settings'

module DiscourseApi
  class Client
    attr_accessor :api_key
    attr_reader :host, :api_username

    include DiscourseApi::API::Categories
    include DiscourseApi::API::Search
    include DiscourseApi::API::SSO
    include DiscourseApi::API::Tags
    include DiscourseApi::API::Topics
    include DiscourseApi::API::Posts
    include DiscourseApi::API::Users
    include DiscourseApi::API::Groups
    include DiscourseApi::API::Invite
    include DiscourseApi::API::PrivateMessages
    include DiscourseApi::API::Notifications
    include DiscourseApi::API::Badges
    include DiscourseApi::API::Email
    include DiscourseApi::API::ApiKey
    include DiscourseApi::API::Backups
    include DiscourseApi::API::Dashboard
    include DiscourseApi::API::Uploads
    include DiscourseApi::API::UserActions
    include DiscourseApi::API::SiteSettings

    def initialize(host, api_key = nil, api_username = nil)
      raise ArgumentError, 'host needs to be defined' if host.nil? || host.empty?
      @host         = host
      @api_key      = api_key
      @api_username = api_username
      @use_relative = check_subdirectory(host)
    end

    def api_username=(api_username)
      @api_username = api_username
      @connection.params['api_username'] = api_username unless @connection.nil?
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

    def ssl(options)
      connection_options[:ssl] = options
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def get(path, params={})
      request(:get, path, params)
    end

    def post(path, params={})
      response = request(:post, path, params)
      case response.status
      when 200
        response.body
      else
        raise DiscourseApi::Error, response.body
      end
    end

    def put(path, params={})
      request(:put, path, params)
    end

    def patch(path, params={})
      request(:patch, path, params)
    end

    def user_agent
      @user_agent ||= "DiscourseAPI Ruby Gem #{DiscourseApi::VERSION}"
    end

    private

    def connection
      @connection ||= Faraday.new connection_options do |conn|
        # Follow redirects
        conn.use FaradayMiddleware::FollowRedirects, limit: 5
        # Allow uploading of files
        conn.request :multipart
        # Convert request params to "www-form-encoded"
        conn.request :url_encoded
        # Parse responses as JSON
        conn.use FaradayMiddleware::ParseJson, content_type: 'application/json'
        # Use Faraday's default HTTP adapter
        conn.adapter Faraday.default_adapter
        #pass api_key and api_username on every request
        unless api_username.nil?
          conn.params['api_key'] = api_key
          conn.params['api_username'] = api_username
        end
      end
    end

    def request(method, path, params={})
      unless Hash === params
        params = params.to_h if params.respond_to? :to_h
      end
      path = @use_relative ? path.sub(/^\//, '') : path
      response = connection.send(method.to_sym, path, params)
      handle_error(response)
      response.env
    rescue Faraday::Error::ClientError, JSON::ParserError
      raise DiscourseApi::Error
    end

    def handle_error(response)
      case response.status
      when 403
        raise DiscourseApi::UnauthenticatedError.new(response.env[:body], response.env)
      when 404, 410
        raise DiscourseApi::NotFoundError.new(response.env[:body], response.env)
      when 422
        raise DiscourseApi::UnprocessableEntity.new(response.env[:body], response.env)
      when 429
        raise DiscourseApi::TooManyRequests.new(response.env[:body], response.env)
      when 500...600
        raise DiscourseApi::Error.new(response.env[:body])
      end
    end

    def check_subdirectory(host)
      URI(host).request_uri != '/'
    end
  end
end
