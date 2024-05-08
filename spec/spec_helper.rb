# frozen_string_literal: true
require "simplecov"

SimpleCov.formatter =
  SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter])

SimpleCov.start { add_filter "/spec/" }

require "discourse_api"
require "rspec"
require "webmock/rspec"
require "ostruct"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

WebMock.disable_net_connect!(allow_localhost: true)

def host
  "http://localhost:3000"
end

def a_delete(path)
  a_request(:delete, path)
end

def a_get(path)
  a_request(:get, path)
end

def a_post(path)
  a_request(:post, path)
end

def a_put(path)
  a_request(:put, path)
end

def stub_delete(path)
  stub_request(:delete, path)
end

def stub_get(path)
  stub_request(:get, path)
end

def stub_post(path)
  stub_request(:post, path)
end

def stub_put(path)
  stub_request(:put, path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def escape_params(params)
  params.map { |key, value| [CGI.escape(key), value].join("=") }.join("&")
end
