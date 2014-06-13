require 'spec_helper'
require 'vin_exploder/exploder'

module VinExploder

  describe Exploder do
    class Adapter
      def initialize(vin_hash={})
        @vin_hash = vin_hash
      end
      def explode(vin)
        @vin_hash
      end
    end

    class PassAdapter
      def explode(vin)
        {pass: "someone else should"}
      end
    end

    class SimpleCache < Cache::Store
      def read(vin)
        @cache ||= {}
        @cache[vin]
      end
      def write(vin, hash)
        @cache ||= {}
        @cache[vin] = hash
      end
    end

    describe '#new' do
      it "should raise a ArgumentError error if no arguments are provided to initialize" do
        expect { Exploder.new }.to raise_error(ArgumentError)
      end

      it "should raise a ArgumentError error if nil is provided to initialize" do
        expect { Exploder.new(nil) }.to raise_error(ArgumentError)
      end

      it "should raise a MissingAdapter error if and empty array is provided to initialize" do
        expect { Exploder.new([]) }.to raise_error(MissingAdapter)
      end

      it "should initialize with a default cache store when no cache argument is passed" do
        store = VinExploder::Cache::Store.new
        adapter = Adapter.new
        VinExploder::Cache::Store.should_receive(:new).exactly(1).times { store }
        exploder = Exploder.new([adapter])
      end
    end

    describe '#get' do
      it "should get a vin Explosion" do
        adapter   = Adapter.new
        exploder  = Exploder.new([adapter])
        explosion = exploder.get('VIN')
        explosion.class.should == VinExploder::Explosion
        explosion.valid?.should == true
        explosion.success?.should == true
      end

      it "should return the cached vin explosion if it is cached" do
        cache     = SimpleCache.new
        cache.write('VIN', {make: 'Ford', model: 'F150'})
        adapter   = Adapter.new
        exploder  = Exploder.new([adapter], cache)
        explosion = exploder.get('VIN')

        explosion.make.should == 'Ford'
      end

      it "should return the adapter vin explosion if it isn't cached" do
        cache     = SimpleCache.new
        adapter   = Adapter.new(make: 'Dodge')
        exploder  = Exploder.new([adapter], cache)
        explosion = exploder.get('VIN')

        explosion.make.should == 'Dodge'
      end

      it "should return results from the first adapter that doesn't pass" do
        cache     = SimpleCache.new
        p1adapter = PassAdapter.new
        p2adapter = PassAdapter.new
        adapter   = Adapter.new(make: 'Subaru', model: 'Impreza')
        exploder  = Exploder.new([p1adapter, p2adapter, adapter])
        explosion = exploder.get('VIN')

        explosion.model.should == 'Impreza'
      end
    end
  end

end
