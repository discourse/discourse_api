# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'discourse_api/version'

Gem::Specification.new do |spec|
  spec.name          = "discourse_api"
  spec.version       = DiscourseApi::VERSION
  spec.authors       = ["Sam Saffron", "John Paul Ashenfelter", "Michael Herold"]
  spec.email         = ["sam.saffron@gmail.com", "john@ashenfelter.com", "michael.j.herold@gmail.com"]
  spec.description   = %q{Discourse API}
  spec.summary       = %q{Allows access to the Discourse API}
  spec.homepage      = "http://github.com/discourse/discourse_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "rb-inotify"
  spec.add_development_dependency "simplecov"
end
