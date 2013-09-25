require 'net/http'
require 'json'

class DiscourseApi::Resource
  attr_accessor :protocol, :host, :port, :api_key, :api_username

  def self.post(args)
    # ruby 1.9.3 for now
    array_args = args.to_a
    method_name, path = array_args[0]
    route_args = {}
    array_args[1..-1].each do |k, v|
      route_args[k] = v
    end

    define_method method_name do |args|
      parsed_path = DiscourseApi::ParsedPath.new(path, route_args)
      perform_post(parsed_path, args)
    end
  end

  def self.get(args)
    # ruby 1.9.3 for now
    array_args = args.to_a
    method_name, path = array_args[0]
    route_args = {}
    array_args[1..-1].each do |k, v|
      route_args[k] = v
    end
    define_method method_name do |args|
      parsed_path = DiscourseApi::ParsedPath.new(path, route_args)
      perform_get(parsed_path, args)
    end
  end

  def api_args(args)
    args.merge(:api_key => self.api_key, :api_username => self.api_username)
  end

  def perform_get(parsed_path, args)
    parsed_path.validate!(args)
    path, actual_args = parsed_path.generate(args)
    actual_args = api_args(actual_args)
    req = Net::HTTP::Get.new(path, initheader = {'Content-Type' =>'application/json'})
    r = http_client.start {|http| http.request(req) }
    parse_result( r.body )
  end

  def perform_post(parsed_path, args)
    parsed_path.validate!(args)
    path, actual_args = parsed_path.generate(args)
    actual_args = api_args(actual_args)

    req = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
    req.body = api_args(actual_args).to_json
    http_client.start {|http| http.request(req) }
  end

  private
    def parse_result( text )
      JSON.parse( text, :create_extensions => false )
    end

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

end
