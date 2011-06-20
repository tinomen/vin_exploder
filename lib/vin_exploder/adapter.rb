
module VinExploder
  
  module Decode
    
    class VinExploderAdapterError < StandardError; end
    
    class AbstractAdapter
      
      def initialize(options={})
        @options = options
      end
      
      # Fetch, normalize and return the decoded data as a hash.
      #
      # *vin*::  
      #    The Vehicle Identification Number
      #
      # == Returns:
      # An array containing the decoded data hash.
      # 
      # Should an error occur while decoding the vin the hash should 
      # include a key of :errors with an array of errors 
      # in the form of: {'error name' => 'error message'}
      # 
      # Normalize the hash from the vendor to use keys known by VinExploder.
      # All keys should be made into symbols following the ruby snake case convention.
      #
      # The keys that must be normalized are as follows:
      # make
      # model
      # year => YYYY
      # driveline => FWD|4WD|AWD
      # body_style
      # fuel_type => GAS|DIESEL|HYBRID
      # trim_level
      # 
      # All remaining keys should be symbols but can remain vendor specific
      def explode(vin)
        raise NotImplementedError.new("Unimplemented explode method.")
      end
      
    end
    
  end
  
end