$:.unshift(File.dirname(__FILE__) + '/../lib')
if ENV["COVERAGE"]
  require 'simplecov'  
  SimpleCov.start 'rails' 
end

require "bundler"
Bundler.setup

require 'rspec'

require 'vin_exploder'

RSpec.configure do |config|

end
