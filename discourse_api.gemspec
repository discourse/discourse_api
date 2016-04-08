# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discourse_api/version'

Gem::Specification.new do |spec|
  spec.name          = "discourse_api"
  spec.version       = DiscourseApi::VERSION
  spec.authors       = ["Sam Saffron", "John Paul Ashenfelter", "Michael Herold", "Blake Erickson"]
  spec.email         = ["sam.saffron@gmail.com", "john@ashenfelter.com", "michael.j.herold@gmail.com", "o.blakeerickson@gmail.com"]
  spec.description   = %q{Discourse API}
  spec.summary       = %q{Allows access to the Discourse API}
  spec.homepage      = "http://github.com/discourse/discourse_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~>0.9.0"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "rack", ">= 1.5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "10.3.2"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.18"
  spec.add_development_dependency "guard-rspec", "~> 4.3"
  spec.add_development_dependency "guard", "~> 2.6"
  spec.add_development_dependency "rb-inotify", "~> 0.9"
  spec.add_development_dependency "simplecov", "~> 0.9"
end
