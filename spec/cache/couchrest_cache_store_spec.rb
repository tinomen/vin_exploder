require 'spec_helper'
require 'vin_exploder/cache'
require 'vin_exploder/cache/couchrest_cache_store'

module VinExploder
module Cache

describe CouchrestCacheStore, :couchdb_required => true do
  let(:db_name) { 'vindecoder_test' }
  let(:options) { {:host => 'http://localhost:5984', :db_name => db_name} }
  let(:store) { CouchrestCacheStore.new options }
  let(:vin) { '3D7LU38C83G854645' }
  let(:doc) { {:vin => vin, :make => 'Ford' } }

  before(:each) do
    srv = CouchRest.new options[:host]
    db = srv.database(options[:db_name])
    db.delete! if db rescue nil
  end

  it "should initialize" do
    store.class.should == CouchrestCacheStore
  end

  it "should read and write a hash" do
    store.read(vin).should be_nil
    store.write(vin, doc)
    store.read(vin).should == doc
  end

  it "should delete a vin from the cache" do
    store.write(vin, doc)
    store.read(vin).should == doc
    store.delete(vin).should be_true
    store.read(vin).should be_nil
  end

  it "should use the value provided by the block if the vin is not in the cache" do
    store.read(vin).should be_nil
    store.fetch(vin) { doc }
    store.read(vin).should == doc
  end

  it "should not yield to the block if the vin is already in the cache" do
    store.write(vin, doc)
    expect{|b|
      store.fetch(vin, &b)
    }.not_to yield_control
  end
end

end
end
