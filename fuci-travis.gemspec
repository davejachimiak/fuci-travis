# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuci/travis/version'

Gem::Specification.new do |spec|
  spec.name          = "fuci-travis"
  spec.version       = Fuci::Travis::VERSION
  spec.authors       = ["Dave Jachimiak"]
  spec.email         = ["dave.jachimiak@gmail.com"]
  spec.description   = %q{Run failures from your last Travis build from the command line.}
  spec.summary       = %q{Run failures from your last Travis build from the command line.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'fuci', '~> 0.1'
  spec.add_dependency 'travis', '~> 1.3'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "minitest-spec-expect", "~> 0.1"
  spec.add_development_dependency "mocha", "~> 0.14"
  spec.add_development_dependency "rake"
end
