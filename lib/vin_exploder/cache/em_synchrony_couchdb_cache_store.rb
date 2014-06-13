require 'em-synchrony/couchdb'

module VinExploder::Cache

  class EMSynchronyCouchDBCacheStore < Store
    def initialize(options={})
      @db_name = options.delete(:db_name)
      @db = EM::Synchrony::CouchDB.new options

      @db.create_db(@db_name) unless @db.get_all_dbs.include?(@db_name)
    end

    def read(vin)
      key = make_vin_cache_key(vin)
      result = @db.get(@db_name, key)['data']
      symbolize_result_hash(result)
    rescue
      nil
    end

    def write(vin, hash)
      key = make_vin_cache_key(vin)
      @db.save(@db_name, "_id" => key, :data => hash)
      hash
    end

    def delete(vin)
      key = make_vin_cache_key(vin)
      result = @db.delete(@db_name, @db.get(@db_name, key))
      !result.nil? && result['ok']
    end
  end

end
