module SimpleCalculator
  extend ActiveSupport::Concern
  
  included do
    attr_accessor :answer_params, :result
  end
  
  module InstanceMethods
  
    # == Object References Are the objects that have been used in calculation
    #   you can then tell the end user more information on the objects; like
    #   some of their characteritics; Example of this may a car and its 
    #   average fuel consumption;
      
    def object_reference_id(object_reference_name = self.object_reference_name)
      answer_params[object_reference_name]
    end

    def object_reference_characteristics(object_reference = self.object_reference)
      object_reference["characteristics"]
    end

    def object_references
      result["object_references"]
    end

    def object_reference(object_reference_id = self.object_reference_id)
      result["object_references"] && result["object_references"][object_reference_id]
    end
    
    # @return [Float]
    def co2
      (result["calculations"]["co2"]["value"] || 0).to_f
    end
    
    # @return [String]
    def co2_units
      result["calculations"]["co2"]["units"] rescue nil
    end
    
    # @return [String]
    def co2_with_units
      "#{co2} #{co2_units}"
    end    
    
    # source links - give you the ability to show the end user 
    # how a calculation was completed at run-time very nice
    def source_links
      result["source"]["main_source_ids"].map do |id|
        "http://browser.carboncalculated.com/main_sources/#{id}"
      end
    end
  end
end