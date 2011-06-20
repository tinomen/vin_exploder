module VinExploder
  
  class MissingAdapter < StandardError
  end
  
  class Exploder
    
    def initialize(adapter, cache=nil)
      raise MissingAdapter.new("No vin decoding vendor adapter has been provided.") if adapter.nil?
      @cache = cache ? cache : Cache::Store.new
      @adapter = adapter
    end
    
    # Get vin Explosion.
    #
    # == Parameters
    # vin:: vehicle identification number 
    #
    # == Return
    # An Explosion object containing the decoded vin attributes
    def get(vin)
      hash = @cache.fetch(vin) do
        # get from vender adapter
        @adapter.explode(vin)
      end
      Explosion.new vin, hash, hash.delete(:errors)
    end
    
  end
end