module VinExploder::Cache
  # An abstract cache store class that acts as a null cache as well
  class Store
    attr_reader :connection
    # Create a new cache.
    def initialize(options = nil)
      @options = options ? options.dup : {}
    end
    # Fetches VIN data from the cache using the given key. If the VIN has been
    # cached, then the VIN attributes are returned.
    #
    # If the VIN is not in the cache (a cache miss occurred),
    # then nil will be returned. However, if a block has been passed, then
    # that block will be run in the event of a cache miss. The return value
    # of the block will be written to the cache under the given VIN,
    # and that return value will be returned.
    #
    #   cache.write("VIN_NUMBER", {:make => 'Ford', :model => 'F150'})
    #   cache.fetch("VIN_NUMBER")  # => {:make => 'Ford', :model => 'F150'}
    #
    #   cache.fetch("VIN_NUMBER_2")   # => nil
    #   cache.fetch("VIN_NUMBER_2") do
    #     {:make => 'Dodge', :model => '1500'}
    #   end
    #   cache.fetch("VIN_NUMBER_2")   # => {:make => 'Dodge', :model => '1500'}
    #
    def fetch(vin)
      hash = read(vin)
      if block_given?
        if hash.nil?
          hash = yield
          # adapter should raise exception on error but in case it doesn't don't write to cache
          write(vin, hash) unless hash.empty? || (hash[:errors] && !hash[:errors].empty?)
        end
      end
      hash
    end
    # Fetches VIN data from the cache, using the given key. If VIN has
    # been cached with the given key, then the VIN attributes are returned. Otherwise,
    # nil is returned.
    def read(vin)
      nil
    end
    # Writes the value to the cache, with the key.
    def write(vin, hash)
      hash
    end
    # Deletes an entry in the cache. Returns +true+ if an entry is deleted.
    def delete(vin)
      true
    end
    protected
    # the cache key for vins should be based on characters 0-8, 10-11.
    # Position 9 is a checksum value and should not be used in the key.
    def make_vin_cache_key(vin)
      key = vin.slice(0,8)
      key << vin.slice(9,2)
    end
    def symbolize_result_hash(hash)
      new_hash = {}
      hash.each{|k,v| new_hash[k.to_sym] = v}
      new_hash
    end
  end
end
