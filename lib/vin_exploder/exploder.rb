module VinExploder
  
  class MissingAdapter < StandardError
  end
  
  class Exploder
    
    def initialize(adapter, cache=nil)
      raise MissingAdapter.new("No vin decoding vendor adapter has been provided.") if adapter.nil?
      @cache = cache ? cache : Cache::Store.new
      @adapter = adapter
    end
    
    def get(vin)
      hash = @cache.fetch(vin) do
        #get from vender
        vender_hash = @adapter.get(vin)
        # normalize
        @adapter.normalize(vender_hash)
      end
      VinExploder::Explosion.new vin, hash
    end
    
  end
end