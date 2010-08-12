# not a big fan of micro testing; more of a black box kind of
# guy but here they are anyway
require File.dirname(__FILE__) + '/../spec_helper'

describe CarCalculator do
  describe "when validating" do    
    should_validate_presence_of(:model)
    should_validate_presence_of(:car)
    should_validate_presence_of(:fuel_type)
    should_validate_presence_of(:manufacture)
    should_validate_presence_of(:units)
    should_validate_inclusion_of(:units, :in => %w(emissions_in_kg_per_km emissions_in_kg_per_mile))
  end
end