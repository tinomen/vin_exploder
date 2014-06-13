require 'spec_helper'
require 'vin_exploder'

describe VinExploder do
  class SimpleAdapter
    def explode(vin)
      if vin == 'GOODVIN'
        {make: 'Ford', model: 'Mustang'}
      else
        {errors: ["This is a bad VIN"]}
      end
    end
  end

  class SimpleCache < VinExploder::Cache::Store
    def read(vin)
      @cache ||= {}
      @cache[vin]
    end
    def write(vin, hash)
      @cache ||= {}
      @cache[vin] = hash
    end
  end

  describe ".config" do
    it "should return a configuration object" do
      VinExploder.config.class.should == VinExploder::Configuration
    end
  end

  describe ".explode" do
    it "should return an explosion object" do
      VinExploder.config.clear_adapters
      VinExploder.config.add_adapter(SimpleAdapter.new)
      VinExploder.config.set_cache(SimpleCache.new)

      explosion = VinExploder.explode('GOODVIN')
      explosion.class.should == VinExploder::Explosion
    end

    it "should return valid data for a good VIN" do
      VinExploder.config.clear_adapters
      VinExploder.config.add_adapter(SimpleAdapter.new)
      VinExploder.config.set_cache(SimpleCache.new)

      explosion = VinExploder.explode('GOODVIN')
      explosion.make.should == 'Ford'
    end

    it "should return a error for a bad VIN" do
      VinExploder.config.clear_adapters
      VinExploder.config.set_cache(SimpleCache.new)
      VinExploder.config.add_adapter(SimpleAdapter.new)

      explosion = VinExploder.explode('BADVIN')
      explosion.errors.include?("This is a bad VIN").should be_true
    end
  end
end
