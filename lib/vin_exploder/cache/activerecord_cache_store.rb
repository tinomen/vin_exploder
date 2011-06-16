require 'active_record'
require 'Base64'

module VinExploder
module Cache
  
  class ActiveRecordCacheStore < Store
    
    def initialize(options = {})
      super
      @model = options[:model_class]
    end
    
    def read(vin)
      key = make_vin_cache_key(vin)
      obj = @model.find_by_key(key)
      obj.all unless obj.nil?
    end
    
    def write(vin, hash)
      key = make_vin_cache_key(vin)
      obj = @model.new hash
      obj.save
      hash
    end
    
    def delete(vin)
      key = make_vin_cache_key(vin)
      obj = @model.find_by_key(key)
      deleted = obj.delete()
      !deleted.nil?
    end
    
  end
  
end
end