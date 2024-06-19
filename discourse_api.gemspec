# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) if !$LOAD_PATH.include?(lib)
require "discourse_api/version"

Gem::Specification.new do |spec|
  spec.name = "discourse_api"
  spec.version = DiscourseApi::VERSION
  spec.authors = ["Sam Saffron", "John Paul Ashenfelter", "Michael Herold", "Blake Erickson"]
  spec.email = %w[
    sam.saffron@gmail.com
    john@ashenfelter.com
    michael.j.herold@gmail.com
    o.blakeerickson@gmail.com
  ]
  spec.description = "Discourse API"
  spec.summary = "Allows access to the Discourse API"
  spec.homepage = "http://github.com/discourse/discourse_api"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 2.7"
  spec.add_runtime_dependency "faraday-follow_redirects"
  spec.add_runtime_dependency "faraday-multipart"
  spec.add_runtime_dependency "rack", ">= 1.6"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rb-inotify", "~> 0.9"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "rubocop-discourse", "= 3.8.1"
  spec.add_development_dependency "syntax_tree", "~> 6.2.0"

  spec.required_ruby_version = ">= 2.7.0"
end
