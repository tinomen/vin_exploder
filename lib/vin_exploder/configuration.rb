module VinExploder

  class Configuration
    attr_reader :adapters, :cache

    def initialize
      @cache    = nil
      @adapters = []
    end

    def set_cache(cache)
      raise NotImplementedError.new("cache should implement 'fetch' method") unless cache.respond_to?(:fetch)
      raise NotImplementedError.new("cache should implement 'read' method") unless cache.respond_to?(:read)
      raise NotImplementedError.new("cache should implement 'write' method") unless cache.respond_to?(:write)
      raise NotImplementedError.new("cache should implement 'delete' method") unless cache.respond_to?(:delete)

      @cache = cache
    end

    def add_adapter(adapter)
      raise NotImplementedError.new("adapter should impement 'explode' method") unless adapter.respond_to?(:explode)
      @adapters << adapter
    end
  end

end
