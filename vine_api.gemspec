# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vine_api/version'

Gem::Specification.new do |spec|
  spec.name          = "vine_api"
  spec.version       = VineApi::VERSION
  spec.authors       = ["Asano Yuuki"]
  spec.email         = ["yuuki.1224.softtennis@gmail.com"]
  spec.description   = %q{This gem is for vine api}
  spec.summary       = %q{This gem is for vine api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "faraday"
  spec.add_development_dependency "faraday_middleware"
end
