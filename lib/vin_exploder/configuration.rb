module VinExploder

  class Configuration
    attr_accessor :cache_options
    attr_reader :adapters

    def initialize
      @cache_store = nil
      @cache_options = {}
      @adapters = []
    end

    def cache_store(*args)
      if args.empty?
        case @cache_store
        when Symbol
          @cache_store = VinExploder::Cache.const_get(@cache_store.to_s.split('_').map{|s| s.capitalize }.join)
        else
          @cache_store
        end
      else
        @cache_store = args.shift
        @cache_options = args.shift || {}
      end
    end

    def add_adapter(adapter)
      raise NotImplementedError.new("unimplemented explode method") unless adapter.respond_to?(:explode)
      @adapters << adapter
    end
  end

end
