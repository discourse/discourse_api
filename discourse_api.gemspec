# frozen_string_literal: true
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discourse_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'discourse_api'
  spec.version       = DiscourseApi::VERSION
  spec.authors       = ['Sam Saffron', 'John Paul Ashenfelter', 'Michael Herold', 'Blake Erickson']
  spec.email         = ['sam.saffron@gmail.com', 'john@ashenfelter.com', 'michael.j.herold@gmail.com', 'o.blakeerickson@gmail.com']
  spec.description   = 'Discourse API'
  spec.summary       = 'Allows access to the Discourse API'
  spec.homepage      = 'http://github.com/discourse/discourse_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'faraday_middleware', '~> 0.10'
  spec.add_dependency 'rack', '>= 1.6'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'rb-inotify', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.67.2'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'webmock', '~> 2.0'

  spec.required_ruby_version = '>= 2.2.3'
end
