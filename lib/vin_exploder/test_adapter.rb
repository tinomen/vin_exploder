require 'vin_exploder/abstract_adapter'

module VinExploder
  
  module Decode
    
    class TestAdapter < AbstractAdapter
      
      # Create new vinquery adapter
      #
      # == Parameters
      # options:: access_code, report_type, url
      def initialize(options={})
        super
      end
      
      def explode(vin)
        fetch(vin)
      end
      
      
      def fetch(vin)
        #could make the hashes more complete
        case vin
          when '3D7LU38C83G854645'
            { :vin => '3D7LU38C83G854645', :vin_key => '3D7LU38C3G', :make => 'Dodge', :model => 'Ram 3500', :year => '2004', :trim_level => 'ST Quad Cab Long Bed 4WD', :fuel_type => 'Diesel', :engine_type => '5.9L L6 OHV 24V TURBO DIESEL', :has_turbo => 'false', :num_cylinders => '6', :number_of_doors => '4', :manufactured_in => 'UNITED STATES', :production_seq_number => 'C27031', :driveline => '4WD', :body_style => "CREW CAB PICKUP 4-DR", :gvwr_class => 'H', :vehicle_type => 'PICKUP', :"anti-brake_system" => '4-Wheel ABS' }
          when '1G1ND52F14M587843'
            { :vin => '1G1ND52F14M587843', :vin_key => '1G1ND52F4M', :make => 'Chevrolet', :model => 'Classic', :year => '2004', :trim_level => 'Fleet', :fuel_type => 'Gas', :engine_type => '2.2L L4 DOHC', :has_turbo => 'false', :num_cylinders => '4', :number_of_doors => '4', :manufactured_in => 'UNITED STATES', :production_seq_number => '587843', :driveline => 'FWD', :body_style => "SEDAN 4-DR", :gvwr_class => 'D', :vehicle_type => 'PASSENGER', :"anti-brake_system" => '4-Wheel ABS' }
          when '12345678912345678'
            { :errors => [{'3' => 'Invalid VIN number: This VIN number did not pass checksum test.'}] }
          when /[IOQ]/
            { :errors => [{'5' => "Invalid VIN number: This VIN number contains invalid letters: I,O or Q."}] }
          else
            { :errors => [{'0' => "VIN not found"}] }
        end
      end
      
      def normalize(vq_hash)
        vq_hash
      end
      
    end
    
  end
  
end
