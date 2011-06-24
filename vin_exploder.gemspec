lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "rake"
require 'vin_exploder/version'

Gem::Specification.new do |s|
  s.name        = "vin_exploder"
  s.version     = VinExploder::VERSION
  s.summary     = "A caching client for vin decoding services"
  s.description = "A caching client for vin decoding web services. The caching allows the consumer to avoid the cost of secondary lookups."
  s.homepage    = "http://github.com/tinomen/vin_exploder"

  s.authors = ["Jake Mallory"]
  s.email   = "tinomen@gmail.com"
  s.files   = FileList["lib/**/*.rb", "[A-Z]*", "spec/**/*"].to_a

  # RDoc settings
  s.extra_rdoc_files = FileList["[A-Z]*"].to_a
  s.rdoc_options     << "--title"        << s.summary <<
                        "--main"         << "README.textile" <<
                        "--line-numbers" << "--charset=UTF-8"
  
  s.required_rubygems_version = ">= 1.3.6"
  s.require_path = 'lib'
  
  # Test settings
  s.test_files = FileList["spec/**/*"].to_a

  # Dependencies
  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new("1.2.0") then
      s.add_development_dependency "rspec", [">= 2.6.0"]
      s.add_development_dependency "simplecov"
      s.add_development_dependency "sequel"
      s.add_development_dependency "sqlite3"
      s.add_development_dependency "couchrest"
      s.add_development_dependency "activerecord", [">= 3.0.0"]
      
    else
      
    end
  else
    
  end
end