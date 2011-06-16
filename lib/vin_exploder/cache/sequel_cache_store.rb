require 'sequel'
require 'Base64'

module VinExploder
module Cache
  
  class SequelCacheStore < Store
    
    def initialize(options = {})
      super
      @connection = Sequel.connect(options)
    end
    
    def read(vin)
      key = make_vin_cache_key(vin)
      data = @connection[:vins].where(:key => key).first
      Marshal.load(Base64.decode64(data[:data])) unless data.nil?
    end
    
    def write(vin, hash)
      key = make_vin_cache_key(vin)
      @connection[:vins].insert(:key => key, :data => Base64.encode64(Marshal.dump(hash)))
      hash
    end
    
    def delete(vin)
      key = make_vin_cache_key(vin)
      result = @connection[:vins].where(:key => key).delete
      result > 0
    end
    
  end
  
end
end