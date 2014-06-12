module VinExploder
  class MissingAdapter < StandardError; end

  class Exploder

    def initialize(adapters, cache=nil)
      raise ArgumentError.new("adapters must be an array") unless adapters.kind_of? Array
      raise MissingAdapter.new("No vin decoding vendor adapter has been provided.") if !adapters || adapters.empty?
      @cache    = cache ? cache : Cache::Store.new
      @adapters = adapters
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
        # find first adapter that doesn't 'pass' on the vin
        @adapters.each do |a|
          results = a.explode(vin)
          break results unless results[:pass]
        end
      end
      errors = hash ? hash.delete(:errors) : []
      data = hash ? hash : {}
      Explosion.new vin, data, errors
    end

  end
end
