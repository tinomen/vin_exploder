require 'vin_exploder/configuration'
require 'vin_exploder/cache'
require 'vin_exploder/explosion'
require 'vin_exploder/exploder'

module VinExploder
  def self.config
    @@config ||= VinExploder::Configuration.new()
  end

  def self.explode(vin)
    @@exploder ||= nil
    if @@exploder.nil?
      cache = config.cache_store ? config.cache_store.new(config.cache_options) : nil
    end
    @@exploder ||= Exploder.new(config.adapters, cache)
    explosion = @@exploder.get(vin)
  end
end
