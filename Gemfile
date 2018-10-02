source 'https://rubygems.org'

gem 'codecov', require: false
gem 'rake'
gem 'rspec'
gem 'rspec_junit_formatter'
gem 'rubocop'
gem 'simplecov'

gemspec

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
