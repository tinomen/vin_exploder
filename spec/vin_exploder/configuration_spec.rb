require 'spec_helper'
require 'ostruct'
require 'vin_exploder/configuration'

module VinExploder
  describe Configuration do

    describe "#set_cache" do
      before(:each) do
        @required_methods = {fetch: {}, read: {}, write: {}, delete: {}}
      end

      it "should raise an error if the cache doesn't provide a 'fetch' method" do
        @required_methods.delete(:fetch)
        cache  = OpenStruct.new(@required_methods)
        config = Configuration.new

        expect { config.set_cache(cache) }.to raise_error(NotImplementedError)
      end

      it "should raise an error if the cache doesn't provide a 'read' method" do
        @required_methods.delete(:read)
        cache  = OpenStruct.new(@required_methods)
        config = Configuration.new

        expect { config.set_cache(cache) }.to raise_error(NotImplementedError)
      end

      it "should raise an error if the cache doesn't provide a 'write' method" do
        @required_methods.delete(:write)
        cache  = OpenStruct.new(@required_methods)
        config = Configuration.new

        expect { config.set_cache(cache) }.to raise_error(NotImplementedError)
      end

      it "should raise an error if the cache doesn't provide a 'delete' method" do
        @required_methods.delete(:delete)
        cache  = OpenStruct.new(@required_methods)
        config = Configuration.new

        expect { config.set_cache(cache) }.to raise_error(NotImplementedError)
      end

      it "should set the cache" do
        cache  = OpenStruct.new(@required_methods)
        config = Configuration.new
        config.set_cache(cache)

        config.cache.should == cache
      end
    end

    describe "#add_adapter" do
      it "should raise an error if the adapter doesn't provide an 'explode' interface" do
        adapter = OpenStruct.new
        config  = Configuration.new

         expect { config.add_adapter(adapter) }.to raise_error(NotImplementedError)
      end

      it "should add an adapter" do
        adapter = OpenStruct.new(explode: {})
        config  = Configuration.new
        count   = config.adapters.count
        config.add_adapter adapter

        (count + 1 == config.adapters.count).should be_true
      end
    end

    describe "#clear_adapters" do
      it "should remove all added adapters" do
        adapter1 = OpenStruct.new(explode: {})
        adapter2 = OpenStruct.new(explode: {})
        config  = Configuration.new

        config.add_adapter(adapter1)
        config.add_adapter(adapter2)
        config.clear_adapters

        config.adapters.should be_empty
      end
    end
  end
end
