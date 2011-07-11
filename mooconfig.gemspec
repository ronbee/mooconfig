# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mooconfig/version"
require "mooconfig.rb"

Gem::Specification.new do |s|
  s.name        = "mooconfig"
  s.version     = MooConfig::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["ronbee"]
  s.email       = ["ronbee.github@gmail.com"]
  s.homepage    = "https://github.com/ronbee"
  s.summary     = %q{Doing config with mongodb}
  s.description = %q{Keeping and managing configuration via MongoDB. Light implementation.}

  s.rubyforge_project = "mooconfig"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
