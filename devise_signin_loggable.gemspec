# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_signin_loggable/version"

Gem::Specification.new do |s|
  s.name        = "devise_signin_loggable"
  s.version     = DeviseSigninLoggable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aaron Klaassen"]
  s.email       = ["aaron@outerspacehero.com"]
  s.homepage    = "https://github.com/aaronklaassen/devise_signin_loggable"
  s.summary     = %q{Log your users' sign-ins.}
  s.description = %q{Every time a user signs in, log the time and IP.}
  s.license     = "MIT"

  s.rubyforge_project = "devise_signin_loggable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'devise', '>= 3.0.0'
  s.add_dependency 'rails',  '>= 3.2.0'

  s.add_development_dependency 'rspec',   '~> 2.14.1'
  s.add_development_dependency 'shoulda', '~> 3.5.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
