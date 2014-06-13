require 'sequel'
require 'base64'

module VinExploder::Cache
  # A VinExploder cache adapter using Sequel for saving the decoded vin attributes.
  #
  # this store assumes there are 2 columns on the table:
  # - *key*: the first 8, 10th and 11th characters of the vin
  # - *data*: A hash of the decoded vin attributes
  class SequelCacheStore < Store

    def initialize(options = {})
      super
      @connection = Sequel.connect(options)
    end

    def read(vin)
      key = make_vin_cache_key(vin)
      data = @connection[:vins].where(:key => key).first
      Marshal.load(data[:data]) unless data.nil?
    end

    def write(vin, hash)
      key = make_vin_cache_key(vin)
      @connection[:vins].insert(:key => key, :data => Marshal.dump(hash))
      hash
    end

    def delete(vin)
      key = make_vin_cache_key(vin)
      result = @connection[:vins].where(:key => key).delete
      result > 0
    end

  end

end
