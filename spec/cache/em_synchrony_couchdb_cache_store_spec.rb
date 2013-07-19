require 'spec_helper'
require 'vin_exploder/cache/em_synchrony_couchdb_cache_store'

module VinExploder
module Cache

describe EMSynchronyCouchDBCacheStore, :couchdb_required => true  do
  let(:db_name) { 'vindecoder_test' }
  let(:options) { {:host => 'localhost', :port => 5984, :db_name => db_name} }
  let(:store) { EMSynchronyCouchDBCacheStore.new options }
  let(:vin) { '3D7LU38C83G854645' }
  let(:doc) { {:vin => vin, :make => 'Ford' } }

  def with_synchrony(&test)
    EM.synchrony do
      test.call
      EM.stop
    end
  end

  before do
    with_synchrony do
      EM::Synchrony::CouchDB.connect(options).delete_db(db_name)
    end
  end

  it "should read and write a hash" do
    with_synchrony do
      store.read(vin).should be_nil
      store.write(vin, doc)
      store.read(vin).should == doc
    end
  end

  it "should delete a vin from the cache" do
    with_synchrony do
      store.write(vin, doc)
      store.read(vin).should == doc
      store.delete(vin).should be_true
      store.read(vin).should be_nil
    end
  end

  it "should use the value provided by the block if the vin is not in the cache" do
    with_synchrony do
      store.read(vin).should be_nil
      store.fetch(vin) { doc }
      store.read(vin).should == doc
    end
  end

  it "should not yield to the block if the vin is already in the cache" do
    with_synchrony do
      store.write(vin, doc)
      expect{|b|
        store.fetch(vin, &b)
      }.not_to yield_control
    end
  end
end

end
end
