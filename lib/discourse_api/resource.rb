require 'net/http'
require 'json'

class DiscourseApi::Resource
  attr_accessor :protocol, :host, :port, :api_key, :api_username

  def self.get(args)
    self.build_request(:get, args)
  end

  def self.post(args)
    self.build_request(:post, args)
  end

  def self.put(args)
    self.build_request(:put, args)
  end

  def api_args(args)
    args.merge(:api_key => self.api_key, :api_username => self.api_username)
  end

  private

  def http_client
    if protocol == 'https'
      client = Net::HTTP.new(host, port)
      client.use_ssl = true
      client.verify_mode = OpenSSL::SSL::VERIFY_NONE
      client
    else
      Net::HTTP.new(host, port)
    end
  end

  def parse_result( text )
    JSON.parse( text, :create_extensions => false )
  end

  def perform(method, parsed_path, args)
    parsed_path.validate!(args)
    path, actual_args = parsed_path.generate(args)
    actual_args = api_args(actual_args)

    request_type = Object.const_get("Net::HTTP::#{method.to_s.capitalize}")
    req = request_type.new(path, initheader = {'Content-Type' =>'application/json'})
    req.body = api_args(actual_args).to_json if [:post, :put].include? method

    http_client.start {|http| http.request(req) }
  end

  def self.build_request(method, args)
    # ruby 1.9.3 for now
    array_args = args.to_a
    method_name, path = array_args[0]
    route_args = {}
    array_args[1..-1].each do |k, v|
      route_args[k] = v
    end

    define_method method_name do |args|
      parsed_path = DiscourseApi::ParsedPath.new(path, route_args)
      perform(method, parsed_path, args)
    end
  end

end
