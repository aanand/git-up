# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'git-up/version'

Gem::Specification.new do |s|
  s.name        = "git-up"
  s.version     = GitUp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aanand Prasad", "Elliot Crosby-McCullough", "Adrian Irving-Beer", "Joshua Wehner"]
  s.email       = ["aanand.prasad@gmail.com", "elliot.cm@gmail.com"]
  s.homepage    = "http://github.com/aanand/git-up"
  s.summary     = "git command to fetch and rebase all branches"
  s.license     = "MIT"

  s.add_dependency "colored", ">= 1.2"
  s.add_dependency "grit"
  s.add_development_dependency "ronn"

  s.files        = Dir.glob("{bin,lib,man}/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
  s.executables  = Dir.glob("bin/*").map(&File.method(:basename))
end
