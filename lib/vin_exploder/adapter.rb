
module VinExploder
  
  module Decode
    
    class AbstractAdapter
      
      def initialize(options={})
        @options = options
      end
      
      # Retrieve the decoded vin data from a decoding service.
      def fetch(vin)
        raise NotImplementedError.new("Unimplemented fetch method.")
      end
      
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
      def normalize(vendor_hash)
        raise NotImplementedError.new("Unimplemented normalize method.")
      end
      
    end
    
  end
  
end