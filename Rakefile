lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/lizard/version'

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:spec, :rubocop]

task :circleci_release do
  @nearest_reachable_tag = `git describe --abbrev=0 --tags 2>/dev/null`.strip.slice!(0)

  if Gem::Version.new(Fastlane::Lizard::VERSION) > Gem::Version.new(@nearest_reachable_tag)
    puts "Releasing new Gem"
    Rake::Task[:release].invoke
  else
    puts "no gem is released"
  end
end
