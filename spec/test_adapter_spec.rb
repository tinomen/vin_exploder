require 'spec_helper'
require 'vin_exploder/test_adapter'

module VinExploder
module Decode
  
describe TestAdapter do
  
  before(:each) do
    @adapter = TestAdapter.new({})
  end
  
  it "should return Dodge Ram for vin 3D7LU38C83G854645" do
    hash = @adapter.explode '3D7LU38C83G854645'
    hash[:make].should == 'Dodge'
    hash[:model].should == 'Ram 3500'
    hash[:fuel_type].should == 'Desiel'
  end
  
  it "should return Chevrolet Classic for vin 1G1ND52F14M587843" do
    hash = @adapter.explode '1G1ND52F14M587843'
    hash[:make].should == 'Chevrolet'
    hash[:model].should == 'Classic'
    hash[:fuel_type].should == 'Gas'
  end
  
  it "should return checksum error for vin 12345678912345678" do
    hash = @adapter.explode '12345678912345678'
    hash[:errors].first.values.first.should == 'Invalid VIN number: This VIN number did not pass checksum test.'
    hash[:make].should be_nil
  end
  
  it "should return invalid letters error for vins with I, O or Q" do
    hash = @adapter.explode 'I2345678912345678'
    hash[:errors].first.values.first.should == 'Invalid VIN number: This VIN number contains invalid letters: I,O or Q.'
    hash[:make].should be_nil
    hash = @adapter.explode 'O2345678912345678'
    hash[:errors].first.values.first.should == 'Invalid VIN number: This VIN number contains invalid letters: I,O or Q.'
    hash = @adapter.explode 'Q2345678912345678'
    hash[:errors].first.values.first.should == 'Invalid VIN number: This VIN number contains invalid letters: I,O or Q.'
  end
  
  it "should return 'VIN not found' error for all other vins" do
    hash = @adapter.explode '1J1ND33F14M537843'
    hash[:errors].first.values.first.should == 'VIN not found'
    hash[:make].should be_nil
  end
end

end
end