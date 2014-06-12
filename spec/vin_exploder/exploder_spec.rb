require 'spec_helper'
require 'vin_exploder/exploder'

module VinExploder

  describe Exploder do
    describe '#new' do
      it "should raise a MissingAdapter error if nil is provided to initialize" do
        expect { Exploder.new(nil) }.to raise_error(MissingAdapter)
      end

      it "should raise a ArgumentError error if no arguments are provided to initialize" do
        expect { Exploder.new }.to raise_error(ArgumentError)
      end

      it "should initialize with a default cache store when no cache argument is passed" do
        s = VinExploder::Cache::Store.new
        VinExploder::Cache::Store.should_receive(:new).exactly(1).times { s }
        e = Exploder.new(double("Adapter"))
      end
    end

    describe '#get' do
      it "should get a vin Explosion" do
        a = double("Adapter")
        a.should_receive(:explode) { {} }
        e = Exploder.new(a)
        ex = e.get('VIN')
        ex.class.should == VinExploder::Explosion
        ex.valid?.should == true
        ex.success?.should == true
      end
    end
  end

end
