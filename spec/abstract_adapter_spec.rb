require 'spec_helper'
require 'vin_exploder/abstract_adapter'

module VinExploder
module Decode
  
describe AbstractAdapter do
  
  it "should raise an NotImplementedError on explode" do
    expect { AbstractAdapter.new.explode("VIN") }.to raise_error(NotImplementedError)
  end
  
end

end
end