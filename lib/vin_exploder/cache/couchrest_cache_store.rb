require 'couchrest'

module VinExploder
module Cache
  
  # A VinExploder cache adapter using CouchDB for saving the decoded vin attributes.
  #
  # this store assumes there is 1 attribute in the document:
  # - *data*: A hash of the decoded vin attributes
  class CouchrestCacheStore < Store
    
    def initialize(options = {})
      super
      srv = CouchRest.new options[:host]
      @db = srv.database!(options[:db_name])
      # vin_view = db.save_doc({"_id" => "_design/vins", :views => {:vins => {:map => 'function(doc){ if(doc.key){ emit(doc.key, doc.data) } }'}}}) unless db.get("_design/vins")
    end
    
    def read(vin)
      key = make_vin_cache_key(vin)
      result = @db.get(key)['data'] rescue nil
      hash = {}
      result.each{|k,v| hash[k.to_sym] = v} unless result.nil?
      hash.empty? ? nil : hash
    end
    
    def write(vin, hash)
      key = make_vin_cache_key(vin)
      @db.save_doc({"_id" => key, :data => hash})
      hash
    end
    
    def delete(vin)
      key = make_vin_cache_key(vin)
      result = @db.delete_doc(@db.get(key))
      !result.nil? && result['ok']
    end
    
  end
  
end
end