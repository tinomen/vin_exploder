require 'spec_helper'
require 'vin_exploder/configuration'

module VinExploder
  describe Configuration do

    describe '#cache_store' do
      it 'should return nil if no cache is set' do
        c = Configuration.new
        c.cache_store.should == nil
      end

      it 'should convert a symbol to a camel case constant within the VinExploder::Cache scope' do
        class VinExploder::Cache::TestSymbolConst; end
        c = Configuration.new
        c.cache_store :test_symbol_const
        c.cache_store.should == VinExploder::Cache::TestSymbolConst
      end

      it 'should return the constant previously set' do
        c = Configuration.new
        c.cache_store String
        c.cache_store.should == String
      end
    end

    describe '#add_adapter' do
      it "should raise an error if the adapter doesn't provide an 'explode' interface" do
        class BadAdapter; end
        adapter = BadAdapter.new
        config  = Configuration.new

        ->{ config.add_adapter(adapter) }.should raise_error(NotImplementedError)
      end

      it 'should add an adapter' do
        class GoodAdapter
          def explode
          end
        end
        adapter = GoodAdapter.new
        config  = Configuration.new
        count   = config.adapters.count
        config.add_adapter adapter

        (count + 1 == config.adapters.count).should be_true
      end
    end
  end
end
