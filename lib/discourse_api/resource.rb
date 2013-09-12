require 'net/http'
require 'json'

class DiscourseApi::Resource
  attr_accessor :host, :port, :api_key, :api_username

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
    r = Net::HTTP.new(host, port).start {|http| http.request(req) }
    puts r.body
    r.body
  end

  def perform_post(parsed_path, args)
    parsed_path.validate!(args)
    path, actual_args = parsed_path.generate(args)
    actual_args = api_args(actual_args)

    req = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
    req.body = api_args(actual_args).to_json
    Net::HTTP.new(host, port).start {|http| http.request(req) }
  end

end
