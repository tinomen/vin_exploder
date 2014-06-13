require 'vin_exploder/configuration'
require 'vin_exploder/cache'
require 'vin_exploder/explosion'
require 'vin_exploder/exploder'

module VinExploder
  def self.config
    @@config ||= VinExploder::Configuration.new()
  end

  def self.explode(vin)
    @@exploder ||= Exploder.new(config.adapters, config.cache)
    @@exploder.get(vin)
  end
end
