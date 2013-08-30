# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ecore/version"

Gem::Specification.new do |s|
  s.name = "ecore-ffi"
  s.version = Ecore::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Wesley Moxam']
  s.email = ['me@wmoxam.com']
  s.homepage = "http://github.com/wmoxam/ecore-ffi"
  s.summary = %q{Low level ruby bindings for Ecore}
  s.description = %q{Low level ruby bindings for Ecore}

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency 'ffi'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end


