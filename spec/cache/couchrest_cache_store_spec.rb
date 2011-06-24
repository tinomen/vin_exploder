require 'spec_helper'
require 'vin_exploder/cache'
require 'vin_exploder/cache/couchrest_cache_store'

module VinExploder
module Cache

describe CouchrestCacheStore do
  before(:each) do
    db_config = {:host => 'http://127.0.0.1:5984', :db_name => 'vindecoder_test'}
    srv = CouchRest.new db_config[:host]
    @db = srv.database(db_config[:db_name])
    @db.delete! if @db rescue nil
    
    @store = CouchrestCacheStore.new(db_config)
  end
  
  it "should initialize" do
    @store.class.should == CouchrestCacheStore
  end
  
  it "should read and write a hash" do
    vin = '3D7LU38C83G854645'
    hash = @store.read(vin)
    hash.should be_nil
    @store.write(vin, {:vin => vin, :make => 'Ford'})
    hash = @store.read(vin)
    hash.should_not be_nil
    hash[:make].should == 'Ford'
  end
  
  it "should fetch and cache new vins" do
    hash = @store.fetch(:fake_vin_number) do
      {:vin => 'fake_vin_number', :make => 'Ford'}
    end
    hash2 = @store.read(:fake_vin_number)
    hash[:vin].should == hash2[:vin]
  end
  
  it "should delete a vin from the cache" do
    hash = @store.read(:fake_vin_number)
    hash.should be_nil
    @store.write(:fake_vin_number, {:vin => 'fake_vin_number', :make => 'Ford'})
    hash = @store.read(:fake_vin_number)
    hash.should_not be_nil
    hash[:make].should == 'Ford'
    deleted = @store.delete(:fake_vin_number)
    deleted.should == true
    hash = @store.read(:fake_vin_number)
    hash.should be_nil
  end
  
end

end
end