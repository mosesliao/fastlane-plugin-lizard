lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/lizard/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-lizard'
  spec.version       = Fastlane::Lizard::VERSION
  spec.author        = 'Moses Liao'
  spec.email         = 'moses.liao.sd@gmail.com'

  spec.summary       = 'Run swift code complexity analytics using Lizard'
  spec.homepage      = "https://github.com/liaogz82/fastlane-plugin-lizard"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_dependency 'bundler'
  spec.add_dependency 'fastlane'
  spec.add_dependency 'pry'
end
