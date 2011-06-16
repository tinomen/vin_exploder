require 'spec_helper'
require 'vin_exploder/adapter'

module VinExploder
module Decode
  
describe AbstractAdapter do
  
  it "should raise an NotImplementedError on fetch" do
    expect { AbstractAdapter.new.fetch("VIN") }.to raise_error(NotImplementedError)
  end
  
  it "should raise an NotImplementedError on fetch" do
    expect { AbstractAdapter.new.normalize({}) }.to raise_error(NotImplementedError)
  end
  
end

end
end