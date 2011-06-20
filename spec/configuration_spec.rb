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
  
  describe '#adapter' do
    it 'should return nil where no adapter defined' do
      c = Configuration.new
      c.adapter.should == nil
    end
    
    it 'should convert a symbol to a camel case constant within the VinExploder::Decode scope' do
      class VinExploder::Decode::TestSymbolConst; end
      c = Configuration.new
      c.adapter :test_symbol_const
      c.adapter.should == VinExploder::Decode::TestSymbolConst
    end
    
    it 'should return the constant previously set' do
      c = Configuration.new
      c.adapter String
      c.adapter.should == String
    end
  end
  
end

end