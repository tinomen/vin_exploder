module VinExploder

  class Configuration
    attr_reader :adapters, :cache

    def initialize
      @cache    = nil
      @adapters = []
    end

    def set_cache(cache)
      raise NotImplementedError.new("cache should implement 'fetch' method") unless cache.respond_to?(:fetch)
      @cache = cache
    end

    def add_adapter(adapter)
      raise NotImplementedError.new("adapter should impement 'explode' method") unless adapter.respond_to?(:explode)
      @adapters << adapter
    end
  end

end
