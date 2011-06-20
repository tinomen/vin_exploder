require 'yaml'

module VinExploder
  
  class Explosion
    
    attr_reader :vin, :success, :errors, :make, :model, :year, :driveline, :body_style, :fuel_type, :all
    
    def initialize(vin, vin_hash, errors={})
      @vin = vin
      @all = vin_hash
      @make = @all[:make]
      @model = @all[:model]
      @year = @all[:year]
      @driveline = @all[:driveline]
      @body_style = @all[:body_style]
      @fuel_type = @all[:fuel_type]
      @trim_level = @all[:trim_level]
      @errors = errors.nil? ? {} : errors
      @success = @errors.empty?
    end
    
    def valid?
      @success
    end
    alias :success? :valid?
    
    # def _dump(level=-1)
    #   [@vin, @all.to_yaml].join('^')
    # end
    # 
    # def self._load(args)
    #   a = *args.split('^')
    #   hash = YAML.load(a[1])
    #   new(a[0], hash)
    # end
    
  end
  
end