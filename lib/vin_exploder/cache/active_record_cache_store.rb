require 'active_record'
require 'base64'

module VinExploder
module Cache
  
  # A VinExploder cache adapter using ActiveRecord for saving the decoded vin attributes.
  #
  # this store assumes a model with 2 attributes:
  # - *key*: the first 8, 10th and 11th characters of the vin
  # - *data*: A hash of the decoded vin attributes
  class ActiveRecordCacheStore < Store
    
    def initialize(options = {})
      super
      @model_class = options[:model_class]
    end
    
    def read(vin)
      key = make_vin_cache_key(vin)
      obj = @model_class.find_by_key(key)
      obj.data unless obj.nil?
    end
    
    def write(vin, hash)
      key = make_vin_cache_key(vin)
      obj = @model_class.new :key => key, :data => hash
      obj.save
      hash
    end
    
    def delete(vin)
      key = make_vin_cache_key(vin)
      obj = @model_class.find_by_key(key)
      deleted = obj.delete()
      !deleted.nil?
    end
    
  end
  
end
end
