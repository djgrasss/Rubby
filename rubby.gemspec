# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubby/version'

Gem::Specification.new do |gem|
  gem.name          = "rubby"
  gem.version       = Rubby::VERSION
  gem.authors       = ["James Harton"]
  gem.email         = ["james@sociable.co.nz"]
  gem.description   = %q{Ruby, the good parts}
  gem.summary       = %q{A little Ruby language}
  gem.homepage      = "http://rubby-lang.org/"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = %w[rubby irbb]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  %w[bundler rspec rspec-mocks guard guard-rspec guard-bundler guard-cucumber guard terminal-notifier-guard cucumber rb-fsevent rake].each do |dep|
    gem.add_development_dependency dep
  end

  %w[polyglot rubby-rltk].each do |dep|
    gem.add_dependency dep
  end
end
