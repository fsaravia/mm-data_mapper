# encoding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "mm-data_mapper"
  spec.authors       = ["Federico Saravia Barrantes"]
  spec.email         = ["fedesaravia+monkey-mailer@gmail.com"]
  spec.description   = %q{DataMapper loader for MonkeyMailer}
  spec.summary       = %q{DataMapper loader for MonkeyMailer}
  spec.homepage      = "https://github.com/fsaravia/mm-data_mapper/"
  spec.version       = '0.0.2'
  spec.license       = "UNLICENSE"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency 'monkey-mailer', '~> 0.0', '>= 0.0.4'
  spec.add_dependency 'data_mapper', '~> 1.2', '>= 1.2.0'
  spec.add_development_dependency 'rspec', '~> 2', '>= 2.12.0'
  spec.add_development_dependency 'dm-mysql-adapter', '~> 1.2', '>= 1.2.0'
  spec.add_development_dependency 'database_cleaner', '~> 1.2', '>= 1.2.0'
  spec.add_development_dependency 'spawn', '~> 0.1', '>= 0.1.4'
end
