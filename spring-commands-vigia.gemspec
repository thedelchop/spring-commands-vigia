# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spring-commands-vigia/version'

Gem::Specification.new do |spec|
  spec.name          = "spring-commands-vigia"
  spec.version       = SpringCommandsVigia::VERSION
  spec.authors       = ["Joseph DelCioppio"]
  spec.email         = ["joseph.delcioppio@gmail.com"]

  spec.description   = %q{vigia command for rspec}
  spec.summary       = %q{vigia command for rspec}
  spec.homepage      = "https://github.com/thedelchop/spring-commands-vigia"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "spring", ">= 0.9.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
