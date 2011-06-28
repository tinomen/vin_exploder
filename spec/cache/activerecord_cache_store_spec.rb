require 'spec_helper'
require 'sqlite3'
require 'vin_exploder/cache'
require 'vin_exploder/cache/activerecord_cache_store'

module VinExploder
module Cache
  
  class TestArCacheStore < ActiveRecord::Base 
    attr_accessor :vin, :make
    serialize :data
    def initialize(attributes={})
      super attributes
      key = attributes.delete(:key)
      # @data = attributes[:data]
      @attributes = {'key' => key, 'vin' => attributes[:vin], 'make' => attributes[:make], 'data' => attributes[:data]}
    end
  end

describe ActiveRecordCacheStore do
  
  before(:all) do
    ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ':memory:')
    ActiveRecord::Schema.define do
      create_table :test_ar_cache_stores, :force => true do |t|
        t.column :key,       :string
        t.column :vin,       :string
        t.column :make,      :string
        t.column :data,      :text
      end
    end
    
    @store = ActiveRecordCacheStore.new :model_class => TestArCacheStore
    
  end
  
  after(:each) do
    TestArCacheStore.delete_all
  end
  
  it "should read and write a hash" do
    hash = @store.read("fake_vin_number")
    hash.should be_nil
    @store.write("fake_vin_number", {:vin => 'fake_vin_number', :make => 'Ford'})
    hash = @store.read("fake_vin_number")
    hash.should_not be_nil
    hash[:make].should == 'Ford'
  end
  
  it "should fetch and cache new vins" do
    hash = @store.fetch("fake_vin_number") do
      {:vin => 'fake_vin_number', :make => 'Ford'}
    end
    hash2 = @store.read("fake_vin_number")
    hash[:vin].should == hash2[:vin]
  end
  
  it "should delete a vin from the cache" do
    hash = @store.read("fake_vin_number")
    hash.should be_nil
    @store.write(:fake_vin_number, {:vin => 'fake_vin_number', :make => 'Ford'})
    hash = @store.read("fake_vin_number")
    hash.should_not be_nil
    hash[:make].should == 'Ford'
    deleted = @store.delete("fake_vin_number")
    deleted.should == true
    hash = @store.read("fake_vin_number")
    hash.should be_nil
  end
  
end

end
end
