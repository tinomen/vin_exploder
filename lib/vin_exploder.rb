
module VinExploder
  
  def self.explode(vin)
    @@exploder ||= nil
    if @@exploder.nil?
      cache = config.cache_store ? config.cache_store.new(config.cache_options) : nil
      adapter = config.adapter.new(config.adapter_options)
    end
    @@exploder ||= Exploder.new(adapter, cache)
    explosion = @@exploder.get(vin)
  end
  
  def self.config
    @@config ||= VinExploder::Configuration.new()
  end
  
end

require 'vin_exploder/configuration'
require 'vin_exploder/cache'
require 'vin_exploder/explosion'
require 'vin_exploder/exploder'
require 'vin_exploder/abstract_adapter'
