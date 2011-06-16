require 'spec_helper'
require 'sqlite'
require 'active_record'
require 'vin_exploder/cache'
require 'vin_exploder/cache/activerecord_cache_store'

module VinExploder
module Cache
  
  class TestArCacheStore; end

describe ActiveRecordCacheStore do
  
  before(:all) do
    @store = ActiveRecordCacheStore.new :model_class => TestArCacheStore
    
  end
  
  after(:each) do
    
  end
  
  it "should read and write a hash" do
    hash = @store.read(:fake_vin_number)
    hash.should be_nil
    @store.write(:fake_vin_number, {:vin => 'fake_vin_number', :make => 'Ford'})
    hash = @store.read(:fake_vin_number)
    hash.should_not be_nil
    hash[:make].should == 'Ford'
  end
  
  it "should fetch and cache new vins" do
    hash = @store.read(:fake_vin_number)
    hash.should be_nil
    
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
