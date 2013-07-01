# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'china_sms/version'

Gem::Specification.new do |spec|
  spec.name          = "china_sms"
  spec.version       = ChinaSMS::VERSION
  spec.authors       = ["saberma"]
  spec.email         = ["mahb45@gmail.com"]
  spec.description   = %q{a gem for chinese people to send sms}
  spec.summary       = %q{a gem for chinese people to send sms}
  spec.homepage      = "https://github.com/saberma/china_sms"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
