require 'spec_helper'

module VinExploder
module Cache

describe Store do
  
  describe '#read' do
    it 'should return the cached vin explosion' do
      Store.new.read('DOESNTMATTER').should == nil
    end
    it 'should return nil if no explosion found' do
      Store.new.read('DOESNTMATTER').should == nil
    end
  end
  
  describe '#write' do
    it 'should return the value that was written' do
      Store.new.write('VIN', 'EXPLODED_VIN').should == 'EXPLODED_VIN'
      Store.new.read('VIN').should == nil
    end
  end
  
  describe '#fetch' do
    it 'should execute the block and pass through #write' do
      store = Store.new
      store.should_receive(:write).with('VIN', 'EXPLODED_VIN').exactly(1).times { 'EXPLODED_VIN' }
      store.fetch('VIN') do
        'EXPLODED_VIN'
      end.should == 'EXPLODED_VIN'
    end
    
    it 'should return nil with no block' do
      store = Store.new
      store.should_receive(:read).with('VIN').exactly(1).times { 'EXPLODED_VIN' }
      store.fetch('VIN').should == 'EXPLODED_VIN'
    end
  end
  
  describe '#delete' do
    it 'should return true if cache item was deleted' do
      Store.new.delete('VIN').should == true
    end
  end

end

end
end