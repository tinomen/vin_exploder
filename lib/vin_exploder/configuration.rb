
module VinExploder
  
  class Configuration
    
    attr_accessor :cache_options, :adapter_options
    
    def initialize
      @cache_store = :disabled
      @cache_options = {}
      @adapter = nil
      @adapter_options = {}
    end
    
    def cache_store(*args)
      if args.empty?
        case @cache_store
        when :disabled
          VinExploder::Cache::Store
        when Symbol
          VinExploder::Cache.const_get(@cache_store.to_s.split('_').map{|s| s.capitalize }.join)
        else
          @cache_store
        end
      else
        @cache_store = args.shift
        @cache_options = args.shift || {}
      end
    end
    
    def adapter(*args)
      if args.empty?
        case @adapter
        when Symbol
          VinExploder::Decode.const_get(@adapter.to_s.split('_').map{|s| s.capitalize }.join)
        else
          @adapter
        end
      else
        @adapter = args.shift
        @adapter_options = args.shift || {}
      end
    end
    
  end
  
end