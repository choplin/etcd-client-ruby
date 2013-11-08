# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'etcd/client/version'

Gem::Specification.new do |spec|
  spec.name          = "etcd-client-ruby"
  spec.version       = Etcd::Client::VERSION
  spec.authors       = ["choplin"]
  spec.email         = ["choplin.choplin@gmail.com"]
  spec.description   = %q{etcd client library}
  spec.summary       = %q{etcd client library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
end
