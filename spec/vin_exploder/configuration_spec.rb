require 'spec_helper'
require 'vin_exploder/configuration'

module VinExploder
  describe Configuration do
    class BadCache; end
    class GoodCache
      def fetch(vin)
        {}
      end
    end
    class BadAdapter; end
    class GoodAdapter
      def explode(vin)
        {}
      end
    end

    describe "#set_cache" do
      it "should raise an error if the cache doesn't provide a 'fetch' method" do
        cache  = BadCache.new
        config = Configuration.new

        expect { config.set_cache(cache) }.to raise_error(NotImplementedError)
      end

      it "should set the cache" do
        cache  = GoodCache.new
        config = Configuration.new
        config.set_cache(cache)

        config.cache.should == cache
      end
    end

    describe "#add_adapter" do
      it "should raise an error if the adapter doesn't provide an 'explode' interface" do
        adapter = BadAdapter.new
        config  = Configuration.new

         expect { config.add_adapter(adapter) }.to raise_error(NotImplementedError)
      end

      it "should add an adapter" do
        adapter = GoodAdapter.new
        config  = Configuration.new
        count   = config.adapters.count
        config.add_adapter adapter

        (count + 1 == config.adapters.count).should be_true
      end
    end
  end
end
