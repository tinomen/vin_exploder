
module VinExploder
  
  def self.explode(vin)
    @@exploder ||= nil
    if @@exploder.nil?
      cache = VinExploder.config.cache_store ? VinExploder.config.cache_store.new(VinExploder.config.cache_options) : nil
      adapter = VinExploder.config.adapter.new(VinExploder.config.adapter_options)
    end
    @@exploder ||= Exploder.new(adapter, cache)
    explosion = @@exploder.get(vin)
  end
  
  def self.config
    @@config ||= VinExploder::Configuration.new()
  end
  
end

require 'vin_exploder/cache'
require 'vin_exploder/explosion'
require 'vin_exploder/exploder'
