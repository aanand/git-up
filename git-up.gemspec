# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'git-up/version'

Gem::Specification.new do |s|
  s.name        = "git-up"
  s.version     = GitUp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aanand Prasad", "Elliot Crosby-McCullough"]
  s.email       = ["aanand.prasad@gmail.com", "elliot.cm@gmail.com"]
  s.homepage    = "http://github.com/aanand/git-up"
  s.summary     = "git command to fetch and rebase all branches"

  s.add_development_dependency "thoughtbot-shoulda"
  s.add_dependency "colored", ">= 1.2"
  s.add_dependency "grit"

  s.files        = Dir.glob("{bin,lib,vendor}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
  s.executables  = Dir.glob("bin/*").map(&File.method(:basename))
end
